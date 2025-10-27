// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => _RoomModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  members: (json['members'] as List<dynamic>).map((e) => e as String).toList(),
  lastMessage: json['last_message'] as String?,
  lastSender: json['last_sender'] as String?,
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$RoomModelToJson(_RoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'members': instance.members,
      'last_message': instance.lastMessage,
      'last_sender': instance.lastSender,
      'unread_count': instance.unreadCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
