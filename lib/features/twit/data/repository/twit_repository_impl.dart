import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/core/response/result.dart';
import 'package:twit/features/local_database/local_storage_service.dart';
import 'package:twit/features/twit/data/models/twit_model.dart';
import 'package:twit/features/twit/domain/repository/twit_repository.dart';
import 'package:twit/services/remote/storage_service.dart';
import 'package:twit/services/remote/twit_service.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/twit_type_enum.dart';

final twitRepositoryProvider = Provider.autoDispose(
  (ref) => TwitRepositoryImpl(
    localStorageService: ref.watch(localStorageServiceProvider),
    twitService: ref.watch(twitServiceProvider),
    storageService: ref.watch(storageServiceProvider),
  ),
);

class TwitRepositoryImpl implements TwitRepository {
  TwitRepositoryImpl({
    required LocalStorageService localStorageService,
    required TwitService twitService,
    required StorageService storageService,
  }) : _localStorageService = localStorageService,
       _twitService = twitService,
       _storageService = storageService;

  final LocalStorageService _localStorageService;
  final TwitService _twitService;
  final StorageService _storageService;

  @override
  Future<Result<String>> createTwit({
    required String content,
    required List<File> files,
    String? link,
    List<String> hashtags = const [],
  }) async {
    try {
      final user = await _localStorageService.getUser();

      if (user == null) {
        return Result.error('User not found');
      }

      TwitModel newTweet = TwitModel(
        content: content,
        hashtags: hashtags,
        link: link,
        id: Uuid().v4(),
        userId: user.id,
        createdAt: DateTime.now().toIso8601String(),
        twitType: files.isEmpty ? TwitType.text : TwitType.image,
      );

      if (files.isNotEmpty) {
        final imageUrl = await _storageService.insertImage(files.first);
        newTweet = newTweet.copyWith(images: [imageUrl]);
      }

      await _twitService.createTwit(newTweet);

      return Result.success("Tweet has been created successfully!");
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } on StorageException catch (e) {
      return Result.error(e.message);
    } catch (e, st) {
      log(e.toString());
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<List<TwitModel>>> getTwits() async {
    try {
      final response = await _twitService.getAllTwit();
      return Result.success(response);
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  /// to be done later

  @override
  Future<void> deleteTwit(String id) {
    // TODO: implement deleteTwit
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> likeTwit({
    required String twitId,
    required List<String> likes,
  }) async {
    try {
      await _twitService.toggleTwitLike(twitId, likes);
      return Result.success("Success");
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Stream<TwitModel> listenToNewTwit(String userId) {
    final streamController = StreamController<TwitModel>();
    _twitService.listenToNewTwit((payload) {
      print("new data inserted: $payload");
      if (payload.eventType == PostgresChangeEvent.insert) {
        final twitModel = TwitModel.fromJson(payload.newRecord);

        if (twitModel.userId.compareTo(userId) == 0 ||
            (twitModel.repostedUserId != null &&
                twitModel.repostedUserId!.compareTo(userId) == 0)) {
          print("same adding to stream");
          streamController.add(twitModel);
        }
      } else if (payload.eventType == PostgresChangeEvent.update) {
        final twitModel = TwitModel.fromJson(payload.newRecord);
        streamController.add(twitModel);
      }
    });
    return streamController.stream;
  }

  @override
  Stream<TwitModel> listenToTwitComment(String userId, String twitId) {
    final streamController = StreamController<TwitModel>();
    _twitService.listenToTwitComment(twitId, (payload) {
      print("new comment changed: $payload");
      if (payload.eventType == PostgresChangeEvent.insert ||
          payload.eventType == PostgresChangeEvent.update) {
        final twitModel = TwitModel.fromJson(payload.newRecord);

        print(twitModel.userId);
        print(userId);

        streamController.add(twitModel);
      }
    });
    return streamController.stream;
  }

  @override
  Future<Result<String>> reTwit({
    required TwitModel repostedTwit,
    required TwitModel twit,
  }) async {
    try {
      await _twitService.createTwit(repostedTwit);
      await _twitService.updateTwit(twit);
      return Result.success("Success");
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<List<TwitModel>>> getTwitComments(String twitId) async {
    try {
      final response = await _twitService.getTwitComments(twitId);
      return Result.success(response);
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<String>> createTwitComment({
    required TwitModel twit,
    required TwitModel parentTwit,
    File? file,
  }) async {
    try {
      if (file != null) {
        final imageUrl = await _storageService.insertImage(file);
        twit = twit.copyWith(images: [imageUrl]);
      }

      await _twitService.createTwit(twit);
      await _twitService.updateTwit(parentTwit);
      return Result.success("Comment added successfully!");
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<List<TwitModel>>> getUserTwits({required String userId}) async {
    try {
      final response = await _twitService.getUserTwits(userId);
      return Result.success(response);
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<TwitModel>> getTwit(String twitId) async {
    try {
      final response = await _twitService.getTwit(twitId);
      return Result.success(response);
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<List<TwitModel>>> getTwitByHashtag(String hashtag) async {
    try {
      final response = await _twitService.getTwitByHashtag(hashtag);
      return Result.success(response);
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
