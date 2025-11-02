import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/core/enums/notification_type_enum.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/notification/data/models/notification_model.dart';
import 'package:twit/features/notification/data/repository/notification_repository_impl.dart';
import 'package:twit/features/notification/domain/repository/notification_repository.dart';

final notificationProvider = StateNotifierProvider<NotificationProvider, bool>(
  (ref) => NotificationProvider(
    notificationRepository: ref.watch(notificationRepositoryProvider),
  ),
);

final getNotificationProvider = FutureProvider<List<NotificationModel>>((
  ref,
) async {
  final currentUser = ref.watch(userProvider);

  if (currentUser == null) {
    return Future.error("No notification");
  }

  final provider = ref.watch(notificationProvider.notifier);
  return provider.getNotification(currentUser.id);
});

final notificationStreamProvider = StreamProvider((ref) {
  final user = ref.watch(userProvider);
  return ref
      .watch(notificationRepositoryProvider)
      .listenToNewNotification(user!.id);
});

class NotificationProvider extends StateNotifier<bool> {
  NotificationProvider({required NotificationRepository notificationRepository})
    : _notificationRepository = notificationRepository,
      super(true);

  final NotificationRepository _notificationRepository;

  Future<void> createNotification({
    required String text,
    required String userId,
    required NotificationType notificationType,
    required String contentId,
  }) async {
    final newNotification = NotificationModel(
      id: Random().nextInt(200000),
      text: text,
      contentId: contentId,
      userId: userId,
      notificationType: notificationType,
      createdAt: DateTime.now().toUtc().toIso8601String(),
    );

    final response = await _notificationRepository.createNotification(
      newNotification,
    );
  }

  Future<List<NotificationModel>> getNotification(String userId) async {
    final result = await _notificationRepository.getNotification(userId);

    if (result.isSuccess) {
      if (result.data!.isEmpty) {
        return [];
      } else {
        return result.data!;
      }
    } else {
      return Future.error(result.error ?? "Unable to fetch notification");
    }
  }

  Future<void> markNotificationAsRead(int notificationId) async {
    await _notificationRepository.markNotificationAsRead(notificationId);
  }

  Future<void> markAllMyNotificationAsRead(String userId) async {
    await _notificationRepository.markAllMyNotificationAsRead(userId);
  }
}
