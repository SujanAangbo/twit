import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/core/response/result.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/features/search/domain/repository/search_repository.dart';
import 'package:twit/services/remote/user_service.dart';

final searchRepositoryProvider = Provider(
  (ref) => SearchRepositoryImpl(userService: ref.watch(userServiceProvider)),
);

class SearchRepositoryImpl implements SearchRepository {
  final UserService _userService;

  SearchRepositoryImpl({required UserService userService})
    : _userService = userService;

  @override
  Future<Result<List<UserModel>>> getUserByName(String name) async {
    try {
      final users = await _userService.searchUserByName(name);

      print(users);

      return Result.success(users);
    } on PostgrestException catch (e) {
      print(e);
      return Result.error(e.message);
    } catch (e) {
      print(e.toString());

      return Result.error(e.toString());
    }
  }
}
