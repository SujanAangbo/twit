import 'package:twit/features/auth/data/models/user_model.dart';

import '../../../../core/response/result.dart';

abstract class SearchRepository {
  Future<Result<List<UserModel>>> getUserByName(String name);
}
