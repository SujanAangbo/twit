import 'package:twit/core/response/result.dart';

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);

  @override
  String toString() => 'Success(data: $data)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class Error<T> extends Result<T> {
  final String message;
  final Exception? exception;

  const Error(this.message, [this.exception]);

  @override
  String toString() => 'Error(message: $message, exception: $exception)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Error<T> &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          exception == other.exception;

  @override
  int get hashCode => message.hashCode ^ exception.hashCode;
}

class Loading<T> extends Result<T> {
  const Loading();

  @override
  String toString() => 'Loading()';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Loading<T> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
