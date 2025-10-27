import 'dart:io';

import 'package:twit/core/response/result.dart';
import 'package:twit/features/auth/data/models/user_model.dart';

abstract class ProfileRepository {
  Future<Result<UserModel>> editProfile({
    required UserModel user,
    File? profileImage,
    File? bannerImage,
  });

  Future<Result<String>> followUser({
    required UserModel currentUser,
    required UserModel otherUser,
  });

  Future<Result<String>> unfollowUser({
    required UserModel currentUser,
    required UserModel otherUser,
  });

  Stream<bool> listenToFollowerChange(String currentUserId, String otherUserId);

  Future<Result<bool>> isFollowing({
    required String currentUserId,
    required String otherUserId,
  });
}
