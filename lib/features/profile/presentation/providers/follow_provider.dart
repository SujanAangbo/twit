import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/profile/data/repository/profile_repository_impl.dart';
import 'package:twit/features/profile/domain/repository/profile_repository.dart';

final followProvider = StateNotifierProviderFamily((ref, String userId) {
  return FollowProvider(
    userId: userId,
    profileRepository: ref.watch(profileRepositoryProvider),
    currentUser: ref.watch(userProvider)!,
  );
});

class FollowProvider extends StateNotifier<bool?> {
  FollowProvider({
    required this.userId,
    required ProfileRepository profileRepository,
    required this.currentUser,
  }) : _profileRepository = profileRepository,
       super(null) {
    isFollowing();
    _profileRepository.listenToFollowerChange(currentUser!.id, userId).listen((
      isFollowing,
    ) {
      state = isFollowing;
    });
  }

  final ProfileRepository _profileRepository;
  final UserModel? currentUser;

  String userId;

  Future<void> isFollowing() async {
    // do the isfollowing task

    final response = await _profileRepository.isFollowing(
      currentUserId: currentUser!.id,
      otherUserId: userId,
    );

    if (response.isSuccess) {
      state = true;
    } else {
      state = false;
    }
  }

  void listenToUserFollowers() {}
}
