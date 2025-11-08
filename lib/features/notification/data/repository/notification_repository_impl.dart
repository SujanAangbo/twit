import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/core/response/result.dart';
import 'package:twit/features/notification/data/models/notification_model.dart';
import 'package:twit/features/notification/domain/repository/notification_repository.dart';
import 'package:twit/services/remote/notification_service.dart';

final notificationRepositoryProvider = Provider((ref) {
  return NotificationRepositoryImpl(
    notificationService: ref.watch(notificationServiceProvider),
  );
});

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService _notificationService;

  NotificationRepositoryImpl({required NotificationService notificationService})
    : _notificationService = notificationService;

  @override
  Future<Result<String>> createNotification(
    NotificationModel notification,
  ) async {
    try {
      await _notificationService.createNotification(notification);

      return Result.success("Notification added successfully");
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<List<NotificationModel>>> getNotification(String userId) async {
    try {
      final notifications = await _notificationService.getUserNotification(
        userId,
      );

      return Result.success(notifications);
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Stream<NotificationModel> listenToNewNotification(String userId) {
    final streamController = StreamController<NotificationModel>();
    _notificationService.listenToNewNotification((payload) {
      if (payload.eventType == PostgresChangeEvent.insert ||
          payload.eventType == PostgresChangeEvent.update) {
        final notification = NotificationModel.fromJson(payload.newRecord);
        if (notification.userId == userId) {
          streamController.add(notification);
        }
      }
    });
    return streamController.stream;
  }

  @override
  Future<Result<String>> markAllMyNotificationAsRead(String userId) async {
    try {
      await _notificationService.markAllMyNotificationAsRead(userId);

      return Result.success("All notifications are marked as read");
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<String>> markNotificationAsRead(int notificationId) async {
    try {
      await _notificationService.markNotificationAsRead(notificationId);

      return Result.success("Notification marked as read");
    } on PostgrestException catch (e) {
      print("error: $e");
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
