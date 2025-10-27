import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/features/local_database/local_storage_service.dart';

import '../../core/response/result.dart';

final localUserService = Provider<LocalUserService>((ref) {
  return LocalUserService(
    localStorageService: ref.watch(localStorageServiceProvider),
  );
});

class LocalUserService {
  LocalUserService({
    // required DatabaseHelper databaseHelper,
    required LocalStorageService localStorageService,
  }) : /*_databaseHelper = databaseHelper,*/
       _localStorageService = localStorageService;

  // final DatabaseHelper _databaseHelper;
  final LocalStorageService _localStorageService;

  Future<Result<UserModel>> getLocalUser() async {
    final user = await _localStorageService.getUser();

    if (user == null) {
      return Result.error('User not found');
    }

    print(user);
    return Result.success(user);
  }
}
