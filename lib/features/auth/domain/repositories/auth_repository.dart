import 'package:twit/core/response/result.dart';
import 'package:twit/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Result<UserModel>> signUp({
    required String name,
    required String dob,
    required String email,
    required String password,
  });

  Future<Result<UserModel>> login({
    required String email,
    required String password,
  });

  Future<Result<UserModel>> getUserDetail({required String id});
}
