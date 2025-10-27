import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twit/core/enums/twit_type_enum.dart';

part 'twit_model.freezed.dart';
part 'twit_model.g.dart';

@freezed
abstract class TwitModel with _$TwitModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TwitModel({
    required String content,
    @Default([]) List<String> hashtags,
    String? link,
    @Default([]) List<String> images,
    required String id,
    required String userId,
    String? createdAt,
    @Default([]) List<String> likes,
    @Default([]) List<String> comments,
    @Default(0) int shareCount,
    required TwitType twitType,
    @Default(false) bool isReposted,
    String? repostedTwitId,
    String? repostedUserId,
    String? replyTo,
    String? replyTwitId,
  }) = _TwitModel;

  factory TwitModel.fromJson(Map<String, dynamic> json) =>
      _$TwitModelFromJson(json);
}
