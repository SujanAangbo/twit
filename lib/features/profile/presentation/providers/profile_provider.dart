import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/core/supabase/supabase_instance.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/local_database/local_storage_service.dart';
import 'package:twit/features/notification/presentation/providers/notification_provider.dart';
import 'package:twit/features/profile/domain/repository/profile_repository.dart';
import 'package:twit/features/profile/presentation/states/profile_state.dart';

import '../../../../app/routes/app_route.gr.dart';
import '../../../../core/enums/notification_type_enum.dart';
import '../../../../core/response/result.dart';
import '../../data/repository/profile_repository_impl.dart';

final profileProvider =
    AsyncNotifierProviderFamily<ProfileProvider, ProfileState, UserModel>(() {
      return ProfileProvider();
    });

class ProfileProvider extends FamilyAsyncNotifier<ProfileState, UserModel> {
  late final ProfileRepository _profileRepository;
  late final NotificationProvider _notificationProvider;

  @override
  Future<ProfileState> build(UserModel user) async {
    _profileRepository = ref.read(profileRepositoryProvider);
    _notificationProvider = ref.read(notificationProvider.notifier);

    final myUserId = ref.read(userProvider)!.id;

    if (myUserId == user.id) {
      return ProfileState(user: user, isFollowing: false);
    }

    final result = await _profileRepository.isFollowing(
      currentUserId: myUserId,
      otherUserId: user.id,
    );

    return ProfileState(user: user, isFollowing: result.data ?? false);
  }

  Future<bool> editProfile({
    required UserModel user,
    File? profile,
    File? banner,
  }) async {
    final oldState = state.value;
    state = AsyncLoading();
    final response = await _profileRepository.editProfile(
      user: user,
      profileImage: profile,
      bannerImage: banner,
    );

    if (response.isSuccess) {
      ref.read(userProvider.notifier).setUser(response.data!);
      state = AsyncData(oldState!.copyWith(user: response.data!));
      return true;
    } else {
      state = AsyncError(response.error!, StackTrace.current);
      return false;
    }
  }

  Future<void> followUser({
    required UserModel currentUser,
    required UserModel otherUser,
  }) async {
    final oldStateValue = state.value;
    state = AsyncData(state.value!.copyWith(isFollowing: null));

    final myUserId = ref.read(userProvider)!.id;

    final result = await _profileRepository.isFollowing(
      currentUserId: myUserId,
      otherUserId: state.value!.user.id,
    );

    if (result.isSuccess) {
      final Result<String> response;

      // perform follow or unfollow
      if (result.data == true) {
        response = await _profileRepository.unfollowUser(
          currentUser: currentUser,
          otherUser: otherUser,
        );
      } else {
        response = await _profileRepository.followUser(
          currentUser: currentUser,
          otherUser: otherUser,
        );

        if (response.isSuccess) {
          await _notificationProvider.createNotification(
            text: "${currentUser.fullName} is following you.",
            userId: otherUser.id,
            notificationType: NotificationType.follow,
            contentId: currentUser.id,
          );
        }
      }

      // change state when there is success otherwise don't change it
      if (response.isSuccess) {
        final followersCount = state.value!.user.followersCount;
        state = AsyncData(
          state.value!.copyWith(
            isFollowing: !(oldStateValue?.isFollowing ?? true),
            user: state.value!.user.copyWith(
              followersCount: followersCount + (result.data == true ? -1 : 1),
            ),
          ),
        );
        return;
      }
      state = AsyncData(oldStateValue!);
      return;
    }

    state = AsyncData(oldStateValue!);
  }

  Future<void> logout(Ref ref, BuildContext context) async {
    /// 1. reset state
    /// 2. clear local db
    /// 3. logout from supabase
    /// 4. navigate to login page

    ref.read(userProvider.notifier).clearUser();
    await ref.read(localStorageServiceProvider).clearUserData();
    await supabaseClient.auth.signOut();
    context.router.pushAndPopUntil(
      LoginRoute(),
      predicate: (route) => route.isFirst,
    );
  }
}
