import 'package:freezed_annotation/freezed_annotation.dart';

part 'follow_model.freezed.dart';
part 'follow_model.g.dart';

@freezed
abstract class FollowModel with _$FollowModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FollowModel({
    required String id,
    required String followerId,
    required String followingId,
    required String createdAt,
  }) = _FollowModel;

  factory FollowModel.fromJson(Map<String, dynamic> json) =>
      _$FollowModelFromJson(json);
}
