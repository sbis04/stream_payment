import 'package:flutter/material.dart';
import 'package:stream_payment/models/transfer.dart';
import 'package:stream_payment/res/pallet.dart';
import 'package:stream_payment/screens/detail_page.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    required this.transaction,
    required this.destWalletAddress,
    required this.amount,
    required this.status,
  });

  final Transfer transaction;
  final String destWalletAddress;
  final int amount;
  final String status;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => DetailPage(
              transaction: transaction,
            ),
          ),
        );
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Pallet.streamBlue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sending To',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      destWalletAddress,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Pallet.streamBlue.withOpacity(0.1),
              width: double.maxFinite,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$',
                      style: TextStyle(fontSize: 50.0),
                    ),
                    Text(
                      '$amount',
                      style: TextStyle(fontSize: 80.0),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Pallet.streamBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'STATUS: ${status == 'PEN' ? 'Pending' : status == 'DEC' ? 'Declined' : 'Completed'}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
