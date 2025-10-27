import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/features/auth/data/repositories/auth_repository_impl.dart';

import '../../../local_database/local_storage_service.dart';
import '../../domain/repositories/auth_repository.dart';

final userProvider = StateNotifierProvider<UserProvider, UserModel?>(
  (ref) => UserProvider(
    null,
    authRepository: ref.watch(authRepositoryProvider),
    localStorageService: ref.watch(localStorageServiceProvider),
  ),
);

final userDetailProvider = FutureProviderFamily<UserModel?, String>((ref, id) {
  final provider = ref.watch(userProvider.notifier);
  return provider.getUserDetail(id);
});

class UserProvider extends StateNotifier<UserModel?> {
  final AuthRepository _authRepository;
  final LocalStorageService _localStorageService;

  UserProvider(
    super.state, {
    required AuthRepository authRepository,
    required LocalStorageService localStorageService,
  }) : _authRepository = authRepository,
       _localStorageService = localStorageService;

  Future<void> setUser(UserModel user) async {
    await _localStorageService.saveUser(user);
    state = user;
  }

  void clearUser() {
    state = null;
  }

  Future<UserModel?> getUserDetail(String id) async {
    final response = await _authRepository.getUserDetail(id: id);

    if (response.isSuccess) {
      return response.data!;
    } else {
      return null;
    }
  }
}
