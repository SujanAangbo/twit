import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:twit/features/auth/presentation/states/signup_state.dart';

import '../../domain/repositories/auth_repository.dart';

final signUpProvider = StateNotifierProvider(
  (ref) => SignUpProvider(
    SignUpState(isLoading: false),
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

class SignUpProvider extends StateNotifier<SignUpState> {
  SignUpProvider(super.state, {required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      state = state.copyWith(isLoading: true);
      final res = await _authRepository.signUp(
        name: nameController.text.trim(),
        dob: dobController.text,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      state = state.copyWith(isLoading: false);

      if (res.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User created successfully'),
            backgroundColor: Colors.green,
          ),
        );
        context.router.pop();
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

  void setDob(DateTime date) {
    dobController.text = date.toIso8601String();
  }

  void clearState() {
    nameController.clear();
    dobController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
