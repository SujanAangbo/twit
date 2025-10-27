// result.dart - Core Result class
import 'package:flutter/material.dart';
import 'package:twit/core/response/result_states.dart';

abstract class Result<T> {
  const Result();

  // Factory constructors
  const factory Result.success(T data) = Success<T>;
  const factory Result.error(String message, [Exception? exception]) = Error<T>;
  const factory Result.loading() = Loading<T>;

  // Getters
  bool get isSuccess => this is Success<T>;
  bool get isError => this is Error<T>;
  bool get isLoading => this is Loading<T>;

  // Safe data access
  T? get data => isSuccess ? (this as Success<T>).data : null;
  String? get error => isError ? (this as Error<T>).message : null;
  Exception? get exception => isError ? (this as Error<T>).exception : null;

  // Helper methods
  Result<U> map<U>(U Function(T) transform) {
    if (isSuccess) {
      return Result.success(transform((this as Success<T>).data));
    } else if (isError) {
      final errorResult = this as Error<T>;
      return Result.error(errorResult.message, errorResult.exception);
    } else {
      return Result.loading();
    }
  }

  // UI helper method
  Widget when({
    required Widget Function() loading,
    required Widget Function(T data) success,
    required Widget Function(String message, Exception? exception) error,
  }) {
    if (isLoading) return loading();
    if (isSuccess) return success((this as Success<T>).data);
    if (isError) {
      final errorResult = this as Error<T>;
      return error(errorResult.message, errorResult.exception);
    }
    return loading(); // fallback
  }

  // Async operations helper
  Future<Result<U>> then<U>(Future<Result<U>> Function(T) operation) async {
    if (isSuccess) {
      return await operation((this as Success<T>).data);
    } else if (isError) {
      final errorResult = this as Error<T>;
      return Result.error(errorResult.message, errorResult.exception);
    } else {
      return Result.loading();
    }
  }
}

// Extension methods for easier usage
extension ResultExtensions<T> on Result<T> {
  // Fold operation
  U fold<U>({
    required U Function() onLoading,
    required U Function(T data) onSuccess,
    required U Function(String message, Exception? exception) onError,
  }) {
    if (isLoading) return onLoading();
    if (isSuccess) return onSuccess((this as Success<T>).data);
    if (isError) {
      final errorResult = this as Error<T>;
      return onError(errorResult.message, errorResult.exception);
    }
    return onLoading(); // fallback
  }

  // Execute side effects
  Result<T> onSuccess(void Function(T data) action) {
    if (isSuccess) action((this as Success<T>).data);
    return this;
  }

  Result<T> onError(
    void Function(String message, Exception? exception) action,
  ) {
    if (isError) {
      final errorResult = this as Error<T>;
      action(errorResult.message, errorResult.exception);
    }
    return this;
  }

  Result<T> onLoading(void Function() action) {
    if (isLoading) action();
    return this;
  }
}
