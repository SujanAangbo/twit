import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/core/enums/notification_type_enum.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/notification/presentation/providers/notification_provider.dart';
import 'package:twit/features/twit/data/models/twit_model.dart';
import 'package:twit/features/twit/domain/repository/twit_repository.dart';
import 'package:uuid/uuid.dart';

import '../../data/repository/twit_repository_impl.dart';

final twitListProvider = AsyncNotifierProvider(() {
  return TwitListProvider.new();
});

final getTwitDetailProvider = FutureProviderFamily<TwitModel, String>((
  ref,
  twitId,
) {
  return ref.watch(twitListProvider.notifier).getTwit(twitId);
});

final getTwitByHashtagProvider = FutureProvider.family((ref, String hashtag) {
  return ref.watch(twitListProvider.notifier).getTwitsByHashtag(hashtag);
});

class TwitListProvider extends AsyncNotifier<List<TwitModel>> {
  late TwitRepository _twitRepository;
  late NotificationProvider _notificationProvider;

  @override
  Future<List<TwitModel>> build() async {
    _twitRepository = ref.watch(twitRepositoryProvider);
    _notificationProvider = ref.watch(notificationProvider.notifier);

    final currentUser = ref.watch(userProvider);

    _twitRepository.listenToNewTwit(currentUser!.id).listen((newTwit) {
      final currentData = List<TwitModel>.from(state.value ?? []);
      final currentDataIds = currentData.map((twit) => twit.id).toList();

      if (currentDataIds.contains(newTwit.id)) {
        final index = currentDataIds.indexOf(newTwit.id);
        currentData[index] = newTwit;
      } else {
        currentData.insert(0, newTwit);
      }

      state = AsyncData(currentData);
    });

    return await getTwits();
  }

  Future<List<TwitModel>> getTwits() async {
    final response = await _twitRepository.getTwits();

    print(response);

    if (response.isSuccess && response.data != null) {
      return Future.value(response.data);
    }

    if (response.isError) {
      return Future.error(response.error ?? "Cannot fetch the twits...");
    }

    return Future.error("Cannot fetch the twits...");
  }

  Future<List<TwitModel>> getTwitsByHashtag(String hashtag) async {
    final response = await _twitRepository.getTwitByHashtag(hashtag);

    print(response);

    if (response.isSuccess && response.data != null) {
      return Future.value(response.data);
    }

    if (response.isError) {
      return Future.error(response.error ?? "Cannot fetch the twits...");
    }

    return Future.error("Cannot fetch the twits...");
  }

  Future<TwitModel> getTwit(String twitId) async {
    final response = await _twitRepository.getTwit(twitId);

    if (response.isSuccess && response.data != null) {
      return Future.value(response.data);
    }

    if (response.isError) {
      return Future.error(response.error ?? "Cannot fetch the twits...");
    }

    return Future.error("Cannot fetch the twits...");
  }

  Future<List<String>> likeTwit(TwitModel twit, UserModel currentUser) async {
    final likes = List<String>.from(twit.likes);
    if (likes.contains(currentUser.id)) {
      likes.remove(currentUser.id);
    } else {
      likes.add(currentUser.id);
    }

    twit = twit.copyWith(likes: likes);

    final response = await _twitRepository.likeTwit(
      twitId: twit.id,
      likes: likes,
    );

    if (response.isSuccess) {
      if (twit.userId != currentUser.id) {
        await _notificationProvider.createNotification(
          text: "${currentUser.fullName} liked your tweet!",
          userId: twit.userId,
          notificationType: NotificationType.like,
          contentId: twit.id,
        );
      }
    }

    return twit.likes;
  }

  Future<List<String>> reTwit(TwitModel twit, UserModel currentUser) async {
    final oldTwit = twit.copyWith(shareCount: twit.shareCount + 1);

    final rePostedTwit = twit.copyWith(
      id: Uuid().v4(),
      isReposted: true,
      repostedTwitId: twit.id,
      createdAt: DateTime.now().toIso8601String(),
      shareCount: 0,
      likes: [],

      // userId: currentUser.id,
      comments: [],
      // repostedUserId: twit.userId,
      repostedUserId: currentUser.id,
    );

    final response = await _twitRepository.reTwit(
      repostedTwit: rePostedTwit,
      twit: oldTwit,
    );

    if (response.isSuccess) {
      if (twit.userId != currentUser.id) {
        await _notificationProvider.createNotification(
          text: "${currentUser.fullName} retweet your tweet!",
          userId: twit.userId,
          notificationType: NotificationType.retweet,
          contentId: rePostedTwit.id,
        );
      }
    }

    return twit.likes;
  }
}
