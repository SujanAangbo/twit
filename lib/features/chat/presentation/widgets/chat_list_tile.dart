import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/routes/app_route.gr.dart';
import '../../../../core/common/date_formatter.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/supabase_constants.dart';
import '../../../../utils/ui/app_cached_network_image.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/user_provider.dart';
import '../../data/models/room_model.dart';

class ChatListTile extends ConsumerWidget {
  const ChatListTile({super.key, required this.friendUser, required this.room});

  final UserModel? friendUser;
  final RoomModel room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider)!;

    final hasUnread = room.unreadCount > 0 && room.lastSender != currentUser.id;

    return InkWell(
      onTap: () {
        context.router.push(MessageRoute(room: room));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: hasUnread ? Color(0xFF1A1F29) : Colors.transparent,
        ),
        child: Row(
          children: [
            // Profile Picture with online indicator
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: hasUnread ? Color(0xFF1D9BF0) : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: AppCachedNetworkImage(
                    imageUrl: friendUser?.profilePicture == null
                        ? AppAssets.profileNetwork
                        : '${SupabaseConstants.storagePath}/${friendUser!.profilePicture}',
                    height: 56,
                    width: 56,
                    isRounded: true,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(width: 12),

            // Name and Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          friendUser?.fullName ?? "Unknown",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.grey[100],
                                fontWeight: hasUnread
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                fontSize: 18,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        DateFormatter.formatTime(
                          DateTime.parse(room.updatedAt),
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: hasUnread
                              ? Color(0xFF1D9BF0)
                              : Colors.grey[600],
                          fontSize: 12,
                          fontWeight: hasUnread
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          room.lastMessage ?? "Be the first one to message",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: hasUnread
                                    ? Colors.grey[300]
                                    : Colors.grey[600],
                                fontSize: 15,
                                fontWeight: hasUnread
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                              ),
                        ),
                      ),
                      if (hasUnread) ...[
                        SizedBox(width: 8),
                        Container(
                          height: 20,
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF1D9BF0), Color(0xFF1A8CD8)],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              room.unreadCount > 99
                                  ? "99+"
                                  : room.unreadCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
