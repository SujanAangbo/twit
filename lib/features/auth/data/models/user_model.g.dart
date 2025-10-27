// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  fullName: json['full_name'] as String,
  dob: json['dob'] as String,
  email: json['email'] as String,
  createdAt: json['created_at'] as String,
  profilePicture: json['profile_picture'] as String?,
  bannerPicture: json['banner_picture'] as String?,
  bio: json['bio'] as String?,
  isVerified: json['is_verified'] as bool? ?? false,
  followersCount: (json['followers_count'] as num?)?.toInt() ?? 0,
  followingCount: (json['following_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'dob': instance.dob,
      'email': instance.email,
      'created_at': instance.createdAt,
      'profile_picture': instance.profilePicture,
      'banner_picture': instance.bannerPicture,
      'bio': instance.bio,
      'is_verified': instance.isVerified,
      'followers_count': instance.followersCount,
      'following_count': instance.followingCount,
    };
