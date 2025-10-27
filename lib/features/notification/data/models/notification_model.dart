import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twit/core/enums/notification_type_enum.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
abstract class NotificationModel with _$NotificationModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory NotificationModel({
    required int id,
    required String text,
    required String contentId,
    required String userId,
    @Default(false) bool isSeen,
    required NotificationType notificationType,
    required String createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
