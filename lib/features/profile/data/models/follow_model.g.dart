// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FollowModel _$FollowModelFromJson(Map<String, dynamic> json) => _FollowModel(
  id: json['id'] as String,
  followerId: json['follower_id'] as String,
  followingId: json['following_id'] as String,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$FollowModelToJson(_FollowModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'follower_id': instance.followerId,
      'following_id': instance.followingId,
      'created_at': instance.createdAt,
    };
