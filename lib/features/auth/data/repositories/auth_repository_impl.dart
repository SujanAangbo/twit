import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/core/response/result.dart';
import 'package:twit/core/supabase/supabase_instance.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/features/auth/domain/repositories/auth_repository.dart';
import 'package:twit/services/remote/user_service.dart';

import '../../../../core/constants/supabase_constants.dart';

final authRepositoryProvider = Provider.autoDispose<AuthRepository>(
  (ref) => AuthRepositoryImpl(userService: ref.watch(userServiceProvider)),
);

class AuthRepositoryImpl implements AuthRepository {
  final UserService _userService;

  AuthRepositoryImpl({required UserService userService})
    : _userService = userService;

  @override
  Future<Result<UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user == null || response.session == null) {
        return Result.error("Cannot login with $email");
      }

      final userData = await _userService.getUserDetail(response.user!.id);

      if (userData == null) {
        return Result.error("Cannot find the user with $email");
      }

      // final userData = await supabaseClient
      //     .from(SupabaseConstants.usersTable)
      //     .select()
      //     .eq('email', email);
      //
      // if (userData.isEmpty) {
      //   return Result.error("Cannot find the user with $email");
      // }
      //
      // print("user data: $userData");
      //
      // final user = UserModel.fromJson(userData.first);
      return Result.success(userData);
    } on AuthApiException catch (e) {
      log(e.message);
      return Result.error(e.message);
    } catch (e) {
      log(e.toString());
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<UserModel>> signUp({
    required String name,
    required String dob,
    required String email,
    required String password,
  }) async {
    try {
      // check for existing user
      final existingUser = await supabaseClient
          .from(SupabaseConstants.usersTable)
          .select()
          .eq('email', email);

      if (existingUser.isNotEmpty) {
        return Result.error("User with ${email} already exists!");
      }

      // do signup thing
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return Result.error("Unable to create account with ${email}");
      }

      // final createdDate = DateTime.tryParse(response.user!.createdAt);
      // print(response.user);
      //
      // print(createdDate!.difference(DateTime.now()).inMinutes);
      // if (createdDate == null) {
      //   print(null);
      //   return Result.error("Unable to create account with ${email}");
      // }
      // if (DateTime.now().difference(createdDate) > Duration(minutes: 1)) {
      //   return Result.error("User with ${email} already exists!");
      // }

      // create new user
      final user = UserModel(
        id: response.user!.id,
        fullName: name,
        dob: dob,
        email: email,
        createdAt: DateTime.now().toIso8601String(),
      );
      final success = await _userService.createUser(user);
      // final result = await supabaseClient
      //       //     .from(SupabaseConstants.usersTable)
      //       //     .insert({
      //       //       'full_name': name,
      //       //       'dob': dob,
      //       //       'email': email,
      //       //       'id': response.user!.id,
      //       //     })
      //       //     .select();
      //       //
      //       // final user = UserModel.fromJson(result.first);

      if (success) {
        return Result.success(user);
      } else {
        return Result.error("Unable to create account with ${email}");
      }
    } on AuthApiException catch (e) {
      print(e);
      return Result.error(e.message);
    } catch (ex) {
      print(ex);
      return Result.error(ex.toString());
    }
  }

  @override
  Future<Result<UserModel>> getUserDetail({required String id}) async {
    try {
      final response = await _userService.getUserDetail(id);

      if (response == null) {
        return Result.error("User not found");
      } else {
        return Result.success(response);
      }
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
