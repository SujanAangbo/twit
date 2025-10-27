import 'package:twit/core/response/result.dart';
import 'package:twit/features/notification/data/models/notification_model.dart';

abstract class NotificationRepository {
  Future<Result<List<NotificationModel>>> getNotification(String userId);

  Future<Result<String>> createNotification(NotificationModel notification);

  Future<Result<String>> markNotificationAsRead(int notificationId);

  Future<Result<String>> markAllMyNotificationAsRead(String userId);

  Stream<NotificationModel> listenToNewNotification(String userId);
}
