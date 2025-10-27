import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/core/response/result.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/features/profile/data/models/follow_model.dart';
import 'package:twit/features/profile/domain/repository/profile_repository.dart';
import 'package:twit/services/remote/user_service.dart';

import '../../../../services/remote/storage_service.dart';

final profileRepositoryProvider = Provider(
  (ref) => ProfileRepositoryImpl(
    userService: ref.watch(userServiceProvider),
    storageService: ref.watch(storageServiceProvider),
  ),
);

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required UserService userService,
    required StorageService storageService,
  }) : _userService = userService,
       _storageService = storageService;

  final UserService _userService;
  final StorageService _storageService;

  @override
  Future<Result<UserModel>> editProfile({
    required UserModel user,
    File? profileImage,
    File? bannerImage,
  }) async {
    try {
      String? profileUrl;
      String? bannerUrl;

      // upload images
      if (profileImage != null) {
        profileUrl = await _storageService.insertImage(profileImage);
      }

      if (bannerImage != null) {
        bannerUrl = await _storageService.insertImage(bannerImage);
      }

      // update user data
      user = user.copyWith(
        profilePicture: profileUrl ?? user.profilePicture,
        bannerPicture: bannerUrl ?? user.bannerPicture,
      );

      final updatedProfile = await _userService.editUserProfile(userData: user);

      print("updated user data: $updatedProfile");

      return Result.success(updatedProfile);
    } on PostgrestException catch (e) {
      print(e.message);
      return Result.error(e.message);
    } on StorageException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      print(e.toString());

      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<String>> followUser({
    required UserModel currentUser,
    required UserModel otherUser,
  }) async {
    try {
      final response = await _userService.followUser(
        followerId: currentUser.id,
        followingId: otherUser.id,
        followerCount: otherUser.followersCount,
        followingCount: currentUser.followingCount,
      );

      return Result.success('User followed successfully');
    } on PostgrestException catch (e) {
      print(e.message);
      return Result.error(e.message);
    } catch (e) {
      print(e.toString());

      return Result.error(e.toString());
    }
  }

  @override
  Stream<bool> listenToFollowerChange(
    String currentUserId,
    String otherUserId,
  ) {
    final streamController = StreamController<bool>();
    _userService.listenToFollowerChange((payload) {
      print("new data inserted: $payload");
      if (payload.eventType == PostgresChangeEvent.insert) {
        final followModel = FollowModel.fromJson(payload.newRecord);

        if (followModel.followerId.compareTo(currentUserId) == 0 &&
            followModel.followingId.compareTo(otherUserId) == 0) {
          streamController.add(true);
        }
      }

      if (payload.eventType == PostgresChangeEvent.delete) {
        final followModel = FollowModel.fromJson(payload.newRecord);
        if (followModel.followerId.compareTo(currentUserId) == 0 &&
            followModel.followingId.compareTo(otherUserId) == 0) {
          streamController.add(false);
        }
      }
    });
    return streamController.stream;
  }

  @override
  Future<Result<String>> unfollowUser({
    required UserModel currentUser,
    required UserModel otherUser,
  }) async {
    try {
      final response = await _userService.unfollowUser(
        followerId: currentUser.id,
        followingId: otherUser.id,
        followerCount: otherUser.followersCount,
        followingCount: currentUser.followingCount,
      );

      return Result.success('User unfollowed successfully');
    } on PostgrestException catch (e) {
      print(e.message);
      return Result.error(e.message);
    } catch (e) {
      print(e.toString());

      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<bool>> isFollowing({
    required String currentUserId,
    required String otherUserId,
  }) async {
    try {
      final response = await _userService.isFollowing(
        currentUserId: currentUserId,
        otherUserId: otherUserId,
      );

      return Result.success(response);
    } on PostgrestException catch (e) {
      print(e.message);
      return Result.error(e.message);
    } catch (e) {
      print(e.toString());

      return Result.error(e.toString());
    }
  }
}
