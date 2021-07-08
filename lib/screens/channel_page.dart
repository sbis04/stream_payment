import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_payment/models/transfer.dart';
import 'package:stream_payment/screens/transaction_page.dart';
import 'package:stream_payment/utils/rapyd_client.dart';
import 'package:stream_payment/widgets/transaction_attachment.dart';
import 'package:stream_payment/widgets/transaction_widget.dart';

class ChannelPage extends StatefulWidget {
  final Channel channel;
  const ChannelPage(this.channel);

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  GlobalKey<MessageInputState> _messageInputKey = GlobalKey();
  RapydClient _rapydClient = RapydClient();

  late final String _sourceWalletId;
  late final String _destinationWalletId;

  bool _isSending = false;

  getWallets() async {
    var members = await widget.channel.queryMembers();
    var destId = members.members[1].user!.extraData['wallet_id'] as String;
    var sourceId = members.members[0].user!.extraData['wallet_id'] as String;

    _sourceWalletId = sourceId;
    _destinationWalletId = destId;
  }

  @override
  void initState() {
    super.initState();
    getWallets();
  }

  Future<void> _onPaymentRequestPressed() async {
    final String? amount = await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => TransactionPage(
          destinationWalletAddress: _destinationWalletId,
        ),
      ),
    );

    if (amount != null) {
      _messageInputKey.currentState?.addAttachment(
        Attachment(
          type: 'payment',
          uploadState: UploadState.success(),
          extraData: {"amount": int.parse(amount)},
        ),
      );
    }
  }

  Widget _buildPaymentMessage(
    BuildContext context,
    Message details,
    List<Attachment> _,
  ) {
    final transaction = Transfer.fromJson(details.attachments.first.extraData);
    final transactionInfo = transaction.data;

    int amount = transactionInfo.amount;
    String destWalletAddress = transactionInfo.destinationEwalletId;
    String status = transactionInfo.status;

    return wrapAttachmentWidget(
      context,
      TransactionWidget(
        transaction: transaction,
        destWalletAddress: destWalletAddress,
        amount: amount,
        status: status,
      ),
      RoundedRectangleBorder(),
      true,
    );
  }

  Future<Message> _performTransaction(Message msg) async {
    if (msg.attachments.isNotEmpty &&
        msg.attachments[0].extraData['amount'] != null) {
      setState(() {
        _isSending = true;
      });

      int amount = msg.attachments[0].extraData['amount'] as int;

      var transactionInfo = await _rapydClient.transferMoney(
        amount: amount,
        sourceWallet: _sourceWalletId,
        destinationWallet: _destinationWalletId,
      );

      var updatedInfo = await _rapydClient.transferResponse(
          id: transactionInfo!.data.id, response: 'accept');

      msg.attachments[0] = Attachment(
        type: 'payment',
        uploadState: UploadState.success(),
        extraData: updatedInfo!.toJson(),
      );

      setState(() {
        _isSending = false;
      });
    }

    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: LoadingOverlay(
        isLoading: _isSending,
        color: Colors.black,
        progressIndicator: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 24.0),
                Text('Sending payment...')
              ],
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: MessageListView(
                customAttachmentBuilders: {'payment': _buildPaymentMessage},
              ),
            ),
            MessageInput(
              key: _messageInputKey,
              preMessageSending: (msg) => _performTransaction(msg),
              attachmentThumbnailBuilders: {
                'payment': (context, attachment) => TransactionAttachment(
                      amount: attachment.extraData['amount'] as int,
                    )
              },
              actions: [
                IconButton(
                  icon: Icon(Icons.payment),
                  onPressed: _onPaymentRequestPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
