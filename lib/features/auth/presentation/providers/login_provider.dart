import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/app/routes/app_route.gr.dart';
import 'package:twit/features/auth/domain/repositories/auth_repository.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/auth/presentation/states/login_state.dart';
import 'package:twit/features/local_database/local_storage_service.dart';

import '../../data/repositories/auth_repository_impl.dart';

final loginProvider = StateNotifierProvider(
  (ref) => LoginProvider(
    LoginState(isLoading: false),
    authRepository: ref.watch(authRepositoryProvider),
    localStorageService: ref.watch(localStorageServiceProvider),
  ),
);

class LoginProvider extends StateNotifier<LoginState> {
  LoginProvider(
    super.state, {
    required AuthRepository authRepository,
    required LocalStorageService localStorageService,
  }) : _authRepository = authRepository,
       _localStorageService = localStorageService;

  final AuthRepository _authRepository;
  final LocalStorageService _localStorageService;

  final TextEditingController emailController = TextEditingController(
    // text: 'aangbooosuzan@gmail.com',
  );
  final TextEditingController passwordController = TextEditingController(
    // text: 'Sujansujan',
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login(BuildContext context, WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      state = state.copyWith(isLoading: true);

      final res = await _authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      state = state.copyWith(isLoading: false);

      if (res.isSuccess) {
        final user = res.data!;

        ref.read(userProvider.notifier).setUser(user);
        context.router.popAndPush(BottomNavBar());
        clearState();
      }

      if (res.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              res.error.toString(),
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void clearState() {
    emailController.clear();
    passwordController.clear();
  }
}
