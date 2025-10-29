// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TwitModel _$TwitModelFromJson(Map<String, dynamic> json) => _TwitModel(
  content: json['content'] as String,
  hashtags:
      (json['hashtags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  link: json['link'] as String?,
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  id: json['id'] as String,
  userId: json['user_id'] as String,
  createdAt: json['created_at'] as String?,
  likes:
      (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  comments:
      (json['comments'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  shareCount: (json['share_count'] as num?)?.toInt() ?? 0,
  twitType: $enumDecode(_$TwitTypeEnumMap, json['twit_type']),
  isReposted: json['is_reposted'] as bool? ?? false,
  repostedTwitId: json['reposted_twit_id'] as String?,
  repostedUserId: json['reposted_user_id'] as String?,
  replyTo: json['reply_to'] as String?,
  replyTwitId: json['reply_twit_id'] as String?,
  event: $enumDecodeNullable(_$TwitEventTypeEnumMap, json['event']),
);

Map<String, dynamic> _$TwitModelToJson(_TwitModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'hashtags': instance.hashtags,
      'link': instance.link,
      'images': instance.images,
      'id': instance.id,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'likes': instance.likes,
      'comments': instance.comments,
      'share_count': instance.shareCount,
      'twit_type': _$TwitTypeEnumMap[instance.twitType]!,
      'is_reposted': instance.isReposted,
      'reposted_twit_id': instance.repostedTwitId,
      'reposted_user_id': instance.repostedUserId,
      'reply_to': instance.replyTo,
      'reply_twit_id': instance.replyTwitId,
      'event': _$TwitEventTypeEnumMap[instance.event],
    };

const _$TwitTypeEnumMap = {TwitType.text: 'text', TwitType.image: 'image'};

const _$TwitEventTypeEnumMap = {
  TwitEventType.CREATE: 'CREATE',
  TwitEventType.UPDATE: 'UPDATE',
  TwitEventType.DELETE: 'DELETE',
  TwitEventType.GET: 'GET',
};
