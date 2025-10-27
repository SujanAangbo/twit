// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: (json['id'] as num).toInt(),
      message: json['message'] as String? ?? '',
      roomId: (json['room_id'] as num).toInt(),
      senderId: json['sender_id'] as String,
      createdAt: json['created_at'] as String,
      isSeen: json['is_seen'] as bool? ?? false,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'room_id': instance.roomId,
      'sender_id': instance.senderId,
      'created_at': instance.createdAt,
      'is_seen': instance.isSeen,
      'image': instance.image,
    };
