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

  await client.connectUser(
    User(
      id: USER_ID,
      extraData: {
        'image':
            'https://local.getstream.io:9000/random_png/?id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZGVsaWNhdGUtZmlyZS02In0.Yfdnsfkt48g1xv3I77mBjlVISnLwMyVUFobBynTf6Jc&name=delicate-fire-6',
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
      home: ChannelListPage(),
    );
  }
}
