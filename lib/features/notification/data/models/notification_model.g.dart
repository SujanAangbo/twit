// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    _NotificationModel(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      contentId: json['content_id'] as String,
      userId: json['user_id'] as String,
      isSeen: json['is_seen'] as bool? ?? false,
      notificationType: $enumDecode(
        _$NotificationTypeEnumMap,
        json['notification_type'],
      ),
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$NotificationModelToJson(
  _NotificationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'content_id': instance.contentId,
  'user_id': instance.userId,
  'is_seen': instance.isSeen,
  'notification_type': _$NotificationTypeEnumMap[instance.notificationType]!,
  'created_at': instance.createdAt,
};

const _$NotificationTypeEnumMap = {
  NotificationType.like: 'like',
  NotificationType.follow: 'follow',
  NotificationType.comment: 'comment',
  NotificationType.retweet: 'retweet',
};
