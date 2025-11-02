import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/core/enums/user_status_enum.dart';

import '../../core/constants/supabase_constants.dart';
import '../../features/auth/data/models/user_model.dart';

final userServiceProvider = Provider((ref) => UserService());

class UserService {
  final _supabase = Supabase.instance.client;
  late final RealtimeChannel _followerStream;

  Future<UserModel?> getUserDetail(String id) async {
    print("userOd: $id");
    final userData = await _supabase
        .from(SupabaseConstants.usersTable)
        .select()
        .eq('id', id);

    print("userdata: $userData");

    if (userData.isEmpty) {
      return null;
    }

    return UserModel.fromJson(userData.first);
  }

  Future<bool> createUser(UserModel user) async {
    final result = await _supabase
        .from(SupabaseConstants.usersTable)
        .upsert(user.toJson())
        .select();

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> verifyUser(String userId) async {
    await _supabase
        .from(SupabaseConstants.usersTable)
        .update({'user_status': UserStatus.verified})
        .eq('id', userId);
  }

  Future<List<UserModel>> searchUserByName(String name) async {
    final result = await _supabase
        .from(SupabaseConstants.usersTable)
        .select()
        .ilike('full_name', "%${name}%")
        .neq('user_status', "unverified");
    // .eq('full_name', name);

    if (result.isNotEmpty) {
      final users = result
          .map((element) => UserModel.fromJson(element))
          .toList();
      return users;
    } else {
      return [];
    }
  }

  Future<UserModel> editUserProfile({required UserModel userData}) async {
    final result = await _supabase
        .from(SupabaseConstants.usersTable)
        .update(userData.toJson())
        .eq('id', userData.id)
        .select();
    // .eq('full_name', name);

    print(result);

    return UserModel.fromJson(result.first);
  }

  Future<bool> unfollowUser({
    required String followerId,
    required String followingId,
    required int followerCount,
    required int followingCount,
  }) async {
    await _supabase
        .from(SupabaseConstants.followsTable)
        .delete()
        .eq('follower_id', followerId)
        .eq('following_id', followingId);

    await _supabase
        .from(SupabaseConstants.usersTable)
        .update({'following_count': followingCount - 1})
        .eq('id', followerId);

    await _supabase
        .from(SupabaseConstants.usersTable)
        .update({'followers_count': followerCount - 1})
        .eq('id', followingId);

    return true;
  }

  Future<bool> followUser({
    required String followerId,
    required String followingId,
    required int followerCount,
    required int followingCount,
  }) async {
    await _supabase.from(SupabaseConstants.followsTable).insert({
      'follower_id': followerId,
      'following_id': followingId,
    });

    await _supabase
        .from(SupabaseConstants.usersTable)
        .update({'following_count': followingCount + 1})
        .eq('id', followerId);

    await _supabase
        .from(SupabaseConstants.usersTable)
        .update({'followers_count': followerCount + 1})
        .eq('id', followingId);

    return true;
  }

  Future<bool> isFollowing({
    required String currentUserId,
    required String otherUserId,
  }) async {
    final result = await _supabase
        .from(SupabaseConstants.followsTable)
        .select()
        .eq('follower_id', currentUserId)
        .eq('following_id', otherUserId);

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  RealtimeChannel listenToFollowerChange(
    void Function(PostgresChangePayload) callback,
  ) {
    _followerStream = _supabase
        .channel('follower_channel')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          table: SupabaseConstants.followsTable,
          schema: 'public',
          callback: callback,
        )
        .subscribe();
    return _followerStream;
  }

  void closeTwitStream() {
    _followerStream.unsubscribe();
  }
}
