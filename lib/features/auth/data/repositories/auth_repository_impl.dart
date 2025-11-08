import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/core/enums/user_status_enum.dart';
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

      if (userData.userStatus == UserStatus.unverified) {
        await _userService.verifyUser(userData.id);
      }

      return Result.success(userData.copyWith(userStatus: UserStatus.verified));
    } on AuthApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
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

      // create new user
      final user = UserModel(
        id: response.user!.id,
        fullName: name,
        dob: dob,
        email: email,
        createdAt: DateTime.now().toUtc().toIso8601String(),
        userStatus: UserStatus.unverified,
      );
      final success = await _userService.createUser(user);

      if (success) {
        return Result.success(user);
      } else {
        return Result.error("Unable to create account with ${email}");
      }
    } on AuthApiException catch (e) {
      return Result.error(e.message);
    } catch (ex) {
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

  @override
  Future<Result<UserModel>> signupWithGoogle() async {
    try {
      final googleSignIn = await GoogleSignIn.instance
        ..initialize(serverClientId: SupabaseConstants.serverClientId);

      final account = await googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      final authentication = account.authentication;
      if (authentication.idToken == null) {
        return Result.error("Sign in cancelled by user.");
      }

      final response = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: authentication.idToken!,
      );

      if (response.user == null) {
        return Result.error("Unable to login with ${account.email}");
      }

      // create new user
      final user = UserModel(
        id: response.user!.id,
        fullName: account.displayName ?? "Unknown",
        profilePicture: account.photoUrl,
        email: account.email,
        createdAt: DateTime.now().toUtc().toIso8601String(),
        userStatus: UserStatus.unverified,
        isVerified: true,
      );

      final existingUser = await _userService.getUserDetail(user.id);

      if (existingUser == null) {
        final success = await _userService.createUser(user);

        if (success) {
          return Result.success(user);
        } else {
          return Result.error("Unable to create account with ${account.email}");
        }
      }

      return Result.success(existingUser);
    } on GoogleSignInException catch (e) {
      print(e);
      return Result.error(e.toString());
    } on AuthApiException catch (e) {
      print(e.message);
      return Result.error(e.message);
    } catch (ex) {
      print(ex.toString());
      return Result.error(ex.toString());
    }
  }
}
