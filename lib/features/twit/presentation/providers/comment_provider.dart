import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/notification_type_enum.dart';
import '../../../../core/enums/twit_type_enum.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/user_provider.dart';
import '../../../notification/presentation/providers/notification_provider.dart';
import '../../data/models/twit_model.dart';
import '../../data/repository/twit_repository_impl.dart';
import '../../domain/repository/twit_repository.dart';

final twitCommentsProvider =
    AsyncNotifierProviderFamily<CommentProvider, List<TwitModel>, String>(
      () => CommentProvider.new(),
    );

class CommentProvider extends FamilyAsyncNotifier<List<TwitModel>, String> {
  late final TwitRepository _twitRepository;
  late final NotificationProvider _notificationProvider;
  late final UserModel? _currentUser;

  late final Stream<TwitModel> commentStream;

  @override
  Future<List<TwitModel>> build(String twitId) async {
    _twitRepository = ref.watch(twitRepositoryProvider);
    _notificationProvider = ref.watch(notificationProvider.notifier);
    _currentUser = ref.watch(userProvider);

    _twitRepository.listenToTwitComment(_currentUser!.id, twitId).listen((
      newTwit,
    ) {
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

    final comments = await getTwitComment(twitId);
    return comments;
  }

  Future<List<TwitModel>> getTwitComment(String twitId) async {
    final response = await _twitRepository.getTwitComments(twitId);

    if (response.isSuccess) {
      return response.data ?? [];
    } else {
      return Future.error(response.error ?? 'Unable to fetch comments');
    }
  }

  Future<bool> createTwitComment(
    String content,
    TwitModel twit,
    UserModel currentUser,
    File? selectedFile,
  ) async {
    final replyTwit = TwitModel(
      userId: currentUser.id,
      content: content,
      id: Uuid().v4(),
      twitType: TwitType.text,
      createdAt: DateTime.now().toUtc().toIso8601String(),
      replyTo: twit.userId,
      replyTwitId: twit.id,
    );

    final response = await _twitRepository.createTwitComment(
      twit: replyTwit,
      parentTwit: twit.copyWith(comments: [currentUser.id, ...twit.comments]),
      file: selectedFile,
    );

    if (response.isSuccess) {
      if (twit.userId != currentUser.id) {
        await _notificationProvider.createNotification(
          text: "${currentUser.fullName} commented on your tweet!",
          userId: twit.userId,
          notificationType: NotificationType.comment,
          contentId: twit.id,
        );
      }
    }

    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
