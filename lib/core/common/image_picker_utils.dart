import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  static Future<File?> pickImage(
    ImageSource source, {
    int imageQuality = 30,
  }) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: imageQuality,
      );
      if (image == null) return null;
      final imageFile = File(image.path);
      print('ImagePath : $imageFile');
      return imageFile;
    } on PlatformException catch (e) {
      print('Error picking image: ${e.message}');
      return null;
    }
  }

  static Future<File?> pickVideo(
    ImageSource source, {
    int imageQuality = 30,
  }) async {
    try {
      final video = await ImagePicker().pickVideo(source: source);
      if (video == null) return null;
      final videoFile = File(video.path);
      return videoFile;
    } on PlatformException catch (e) {
      print('Error picking image: ${e.message}');
      return null;
    }
  }

  /// Picks multiple images and returns a list of file paths
  static Future<List<File>?> pickMultipleImages({int imageQuality = 30}) async {
    try {
      final images = await ImagePicker().pickMultiImage(
        imageQuality: imageQuality,
      );
      if (images.isEmpty) return null;

      List<File> imageFiles = images.map((image) => File(image.path)).toList();
      print('Selected Images: $imageFiles');
      return imageFiles;
    } on PlatformException catch (e) {
      print('Error picking multiple images: ${e.message}');
      return null;
    }
  }
}
