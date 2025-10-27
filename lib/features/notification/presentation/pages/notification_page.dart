import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:twit/app/routes/app_route.gr.dart';
import 'package:twit/core/constants/app_assets.dart';
import 'package:twit/core/enums/notification_type_enum.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/notification/presentation/providers/notification_provider.dart';
import 'package:twit/features/notification/presentation/widgets/notification_loader_widget.dart';
import 'package:twit/features/twit/presentation/providers/twit_list_provider.dart';
import 'package:twit/utils/ui/default_app_bar.dart';

@RoutePage()
class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  Widget getNotificationLeading(NotificationType notificationType) {
    Color color;
    String icon;
    switch (notificationType) {
      case NotificationType.like:
        color = const Color(0xFFE91E63);
        icon = AppAssets.likeOutlinedIcon;
      case NotificationType.follow:
        color = const Color(0xFF2196F3);
        icon = AppAssets.searchIcon;
      case NotificationType.comment:
        color = const Color(0xFF4CAF50);
        icon = AppAssets.commentIcon;
      case NotificationType.retweet:
        color = const Color(0xFFFFC107);
        icon = AppAssets.retweetIcon;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        height: 22,
        width: 22,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getNotificationProvider);
    final provider = ref.watch(notificationProvider.notifier);

    return Scaffold(
      appBar: DefaultAppBar(
        title: "Notifications",
        centerTitle: true,
        leading: SizedBox.shrink(),
      ),
      body: state.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none_rounded,
                    size: 80,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No notifications yet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "When you get notifications, they'll show up here",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          ref.watch(notificationStreamProvider).whenData((newNotification) {
            if (newNotification.isSeen) {
              final index = data.indexWhere(
                (notification) => notification.id == newNotification.id,
              );
              if (index != -1) {
                data[index] = newNotification;
              }
            } else {
              ref
                  .watch(getNotificationProvider)
                  .value
                  ?.insert(0, newNotification);
            }
          });

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final notification = data[index];
              final isUnread = notification.isSeen == false;

              return InkWell(
                onTap: () async {
                  provider.markNotificationAsRead(notification.id);
                  switch (notification.notificationType) {
                    case NotificationType.like:
                    case NotificationType.comment:
                    case NotificationType.retweet:
                      final twitData = await ref.read(
                        getTwitDetailProvider(notification.contentId).future,
                      );
                      context.router.push(TwitDetailRoute(twit: twitData));
                    case NotificationType.follow:
                      final userData = await ref.read(
                        userDetailProvider(notification.contentId).future,
                      );
                      context.router.push(ProfileRoute(user: userData!));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isUnread
                        ? const Color(0xFF1E1E1E)
                        : Colors.transparent,
                    border: Border(
                      left: BorderSide(
                        color: isUnread
                            ? const Color(0xFF2196F3)
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getNotificationLeading(notification.notificationType),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.text,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isUnread
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isUnread
                                    ? Colors.white
                                    : Colors.grey[300],
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // You can add timestamp here if available
                            Text(
                              timeago.format(
                                DateTime.parse(notification.createdAt),
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (isUnread)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2196F3),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF2196F3).withOpacity(0.5),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 1,
                thickness: 0.5,
                color: Colors.grey[800],
                // indent: 80,
              );
            },
          );
        },
        error: (err, st) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 60,
                  color: Colors.red[400],
                ),
                const SizedBox(height: 16),
                Text(
                  "Something went wrong",
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                const SizedBox(height: 8),
                Text(
                  err.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
        loading: () {
          return NotificationLoaderWidget();
        },
      ),
    );
  }
}
