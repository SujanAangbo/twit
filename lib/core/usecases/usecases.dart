import 'package:twit/core/response/result.dart';

abstract interface class Usecases<SuccessType, Params> {
  Future<Result<SuccessType>> call(Params params);
}

class NoParams {}
