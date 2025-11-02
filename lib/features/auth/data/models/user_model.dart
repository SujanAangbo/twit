import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twit/core/enums/user_status_enum.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@Freezed()
abstract class UserModel with _$UserModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserModel({
    required String id,
    required String fullName,
    String? dob,
    required String email,
    required String createdAt,
    String? profilePicture,
    String? bannerPicture,
    String? bio,
    @Default(false) bool isVerified,
    @Default(0) int followersCount,
    @Default(0) int followingCount,
    required UserStatus userStatus,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
