import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'screens/channel_list_page.dart';
import 'secrets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final client = StreamChatClient(
    STREAM_KEY,
    logLevel: Level.OFF,
  );

  const String _myWalletId = 'ewallet_3d63cc520dff85b043914de569390fd1';
  const USER_ID = 'sbis04';

  await client.connectUser(
    User(
      id: USER_ID,
      extraData: {
        'wallet_id': _myWalletId,
        'name': 'Souvik Biswas',
        'image': 'https://i.pravatar.cc/150?img=8',
      },
    ),
    USER_TOKEN,
  );

  final channel = client.channel('messaging', id: 'p2p-payment');
  await channel.watch();

  runApp(MyApp(client, channel));
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;
  final Channel channel;

  MyApp(this.client, this.channel);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        return StreamChat(
          child: widget!,
          client: client,
        );
      },
      debugShowCheckedModeBanner: false,
      home: ChannelListPage(channel),
    );
  }
}
