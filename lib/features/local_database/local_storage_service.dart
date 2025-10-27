import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/features/local_database/local_storage.dart';
import 'package:twit/features/local_database/local_storage_key.dart';

final localStorageServiceProvider = Provider(
  (ref) => LocalStorageService(localStorage: ref.watch(localStorageProvider)),
);

class LocalStorageService {
  LocalStorageService({required LocalStorage localStorage})
    : _localStorage = localStorage;

  final LocalStorage _localStorage;

  Future<bool> saveUser(UserModel user) async {
    await saveUserId(user.id);
    return await _localStorage.writeJson(LocalStorageKeys.user, user.toJson());
  }

  Future<UserModel?> getUser() async {
    final userJson = await _localStorage.readJson(LocalStorageKeys.user);

    if (userJson == null) {
      return null;
    }

    print("inside : $userJson");

    final user = UserModel.fromJson(userJson);
    print(user);
    return user;
  }

  Future<bool> saveUserId(String id) async {
    return await _localStorage.write(LocalStorageKeys.userId, id);
  }

  String? getUserId() {
    return _localStorage.read<String>(LocalStorageKeys.userId);
  }

  Future<void> clearUserData() async {
    await _localStorage.clear();
  }
}
