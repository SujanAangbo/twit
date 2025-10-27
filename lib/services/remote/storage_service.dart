import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/core/constants/constants.dart';
import 'package:uuid/uuid.dart';

final storageServiceProvider = Provider((ref) => StorageService());

class StorageService {
  final supabase = Supabase.instance.client;

  Future<String> insertImage(File file) async {
    final imageName = Uuid().v4();
    final imageExtension = file.path.split('.').last;
    final response = await supabase.storage
        .from(SupabaseConstants.twitImageBucket)
        .upload('/${imageName}.${imageExtension}', file);

    return response;
  }
}
