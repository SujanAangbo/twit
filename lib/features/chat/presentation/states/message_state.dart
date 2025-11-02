import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/message_model.dart';

part 'message_state.freezed.dart';

@freezed
abstract class MessageState with _$MessageState {
  const factory MessageState({
    required bool isLoading,
    required List<MessageModel> messages,
  }) = _MessageState;
}
