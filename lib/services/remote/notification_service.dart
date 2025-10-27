import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/features/notification/data/models/notification_model.dart';

import '../../core/constants/supabase_constants.dart';

final notificationServiceProvider = Provider((ref) => NotificationService());

class NotificationService {
  final _supabase = Supabase.instance.client;
  late final RealtimeChannel _notificationStream;

  Future<void> createNotification(NotificationModel notification) async {
    await _supabase
        .from(SupabaseConstants.notificationTable)
        .insert(notification.toJson()..remove('id'));
  }

  Future<List<NotificationModel>> getUserNotification(String userId) async {
    final result = await _supabase
        .from(SupabaseConstants.notificationTable)
        .select()
        .eq('user_id', userId)
        .order('created_at');

    if (result.isNotEmpty) {
      final notifications = result
          .map((element) => NotificationModel.fromJson(element))
          .toList();
      return notifications;
    } else {
      return [];
    }
  }

  Future<void> markNotificationAsRead(int notificationId) async {
    print("notification Id: $notificationId");
    await _supabase
        .from(SupabaseConstants.notificationTable)
        .update({'is_seen': true})
        .eq('id', notificationId);
  }

  Future<void> markAllMyNotificationAsRead(String userId) async {
    await _supabase
        .from(SupabaseConstants.notificationTable)
        .update({'is_seen': true})
        .eq('user_id', userId);
  }

  RealtimeChannel listenToNewNotification(
    void Function(PostgresChangePayload) callback,
  ) {
    _notificationStream = _supabase
        .channel('notification_channel')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          table: SupabaseConstants.notificationTable,
          schema: 'public',
          callback: callback,
        )
        .subscribe();
    return _notificationStream;
  }

  void closeTwitStream() {
    _notificationStream.unsubscribe();
  }
}
