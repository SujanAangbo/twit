import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_twit_state.freezed.dart';

@freezed
abstract class CreateTwitState with _$CreateTwitState {
  const factory CreateTwitState({
    @Default([]) List<File> images,
    @Default(false) bool isLoading,
  }) = _CreateTwitState;
}
