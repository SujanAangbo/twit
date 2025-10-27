import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/data/models/user_model.dart';

part 'profile_state.freezed.dart';

/// isFollowing is nullable. If it is an initial state or when changing the
/// following state, isFollowing will be null. null value is used to show
/// loading indicator in the following button of user profile.

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({required UserModel user, bool? isFollowing}) =
      _ProfileState;
}
