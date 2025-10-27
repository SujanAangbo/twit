import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/chat/presentation/providers/chat_provider.dart';
import 'package:twit/utils/ui/default_app_bar.dart';

import '../widgets/chat_list_tile.dart';

@RoutePage()
class ChatListPage extends ConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getAllRoomProvider);

    ref.watch(roomChangeProvider).whenData((roomData) {
      final existingRooms = state.value ?? [];
      final existingRoomsId = existingRooms.map((room) => room.id).toList();

      if (existingRoomsId.contains(roomData.id)) {
        // update
        final index = existingRoomsId.indexOf(roomData.id);
        existingRooms[index] = roomData;
      } else {
        // insert
        state.value?.insert(0, roomData);
      }
    });

    return Scaffold(
      appBar: DefaultAppBar(
        title: "Messages",
        hasBottomDivider: false,
        leading: SizedBox.shrink(),
      ),
      body: state.when(
        data: (data) {
          final currentUser = ref.watch(userProvider);

          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Color(0xFF1A1F29),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 64,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "No conversations yet",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Start chatting with your friends",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.only(top: 8),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final room = data[index];
              final friendUser = (room.members.toList())
                ..remove(currentUser!.id);

              return ref
                  .watch(
                    userDetailProvider(
                      friendUser.firstOrNull ?? currentUser.id,
                    ),
                  )
                  .when(
                    data: (user) {
                      return ChatListTile(room: room, friendUser: user);
                    },
                    error: (err, st) {
                      return SizedBox.shrink();
                    },
                    loading: () {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Color(0xFF1A1F29),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1A1F29),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: 200,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1A1F29),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Color(0xFF2F3336),
                height: 1,
                thickness: 0.5,
              );
            },
          );
        },
        error: (err, st) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
                SizedBox(height: 16),
                Text(
                  "Something went wrong",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.grey[300]),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    err.toString(),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(color: Color(0xFF1D9BF0)),
          );
        },
      ),
    );
  }
}
