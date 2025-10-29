import 'dart:io';

import 'package:twit/core/response/result.dart';

import '../../data/models/twit_model.dart';

abstract class TwitRepository {
  Future<Result<String>> createTwit({
    required String content,
    required List<File> files,
    String? link,
    List<String> hashtags = const [],
  });

  Future<Result<List<TwitModel>>> getTwits();

  Future<Result<TwitModel>> getTwit(String twitId);

  Future<Result<List<TwitModel>>> getTwitByHashtag(String hashtag);

  Future<Result<List<TwitModel>>> getTwitComments(String twitId);

  Future<Result<String>> likeTwit({
    required String twitId,
    required List<String> likes,
  });

  Future<Result<String>> reTwit({
    required TwitModel repostedTwit,
    required TwitModel twit,
  });

  Future<Result<List<TwitModel>>> getUserTwits({required String userId});

  Future<Result<String>> createTwitComment({
    required TwitModel twit,
    required TwitModel parentTwit,
    File? file,
  });

  Stream<TwitModel> listenToNewTwit(String userId);

  Stream<TwitModel> listenToNewUserTwit(String userId);

  Stream<TwitModel> listenToTwitComment(String userId, String twitId);

  Future<Result<bool>> deleteTwit(String id);
}
