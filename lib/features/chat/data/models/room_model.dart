import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

@freezed
abstract class RoomModel with _$RoomModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RoomModel({
    required int id,
    String? name,
    required List<String> members,
    String? lastMessage,
    String? lastSender,
    @Default(0) int unreadCount,
    required String createdAt,
    required String updatedAt,
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
}
