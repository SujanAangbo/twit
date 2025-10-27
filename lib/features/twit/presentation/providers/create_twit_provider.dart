import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twit/core/common/snackbar.dart';
import 'package:twit/features/twit/domain/repository/twit_repository.dart';
import 'package:twit/features/twit/presentation/states/create_twit_state.dart';

import '../../../../core/common/image_picker_utils.dart';
import '../../../../utils/twit_utils.dart';
import '../../data/repository/twit_repository_impl.dart';

final createTwitProvider = StateNotifierProvider((ref) {
  return CreateTwitProvider(twitRepository: ref.watch(twitRepositoryProvider));
});

class CreateTwitProvider extends StateNotifier<CreateTwitState> {
  final TwitRepository _twitRepository;

  CreateTwitProvider({required TwitRepository twitRepository})
    : _twitRepository = twitRepository,
      super(const CreateTwitState());

  Future<void> pickTwitImages({bool isMultiple = true}) async {
    List<File>? selectedImages;
    if (isMultiple) {
      selectedImages = await ImagePickerUtil.pickMultipleImages();
    } else {
      final image = await ImagePickerUtil.pickImage(ImageSource.gallery);
      selectedImages = image == null ? null : [image];
    }
    state = state.copyWith(images: selectedImages ?? []);
  }

  void removeImage(int index) {
    final images = List<File>.from(state.images);

    images.removeAt(index);

    state = state.copyWith(images: images);
  }

  void set loader(bool value) => state = state.copyWith(isLoading: value);

  Future<void> createTwit(String content, BuildContext context) async {
    print(content);
    print(state.images);
    state = state.copyWith(isLoading: true);

    final hashtags = getHashtags(content);
    final link = getLink(content);

    final response = await _twitRepository.createTwit(
      content: content,
      files: state.images,
      hashtags: hashtags,
      link: link,
    );

    state = state.copyWith(isLoading: false);

    if (response.isSuccess) {
      context.router.maybePop();
      showSnackBar(
        context: context,
        message: response.data ?? '',
        status: SnackBarStatus.success,
      );
    }

    if (response.isError) {
      showSnackBar(
        context: context,
        message: response.error ?? '',
        status: SnackBarStatus.error,
      );
    }
  }
}
