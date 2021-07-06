import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_page.dart';

class ChannelListPage extends StatelessWidget {
  final Channel channel;

  const ChannelListPage(this.channel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Chat'),
      ),
      body: ChannelsBloc(
        child: ChannelListView(
          filter: Filter.in_('members', [StreamChat.of(context).user!.id]),
          sort: [SortOption('last_message_at')],
          pagination: PaginationParams(limit: 30),
          channelWidget: Builder(
            builder: (context) => ChannelPage(channel),
          ),
        ),
      ),
    );
  }
}
