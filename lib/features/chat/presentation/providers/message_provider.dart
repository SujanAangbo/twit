import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/chat/presentation/states/message_state.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/providers/user_provider.dart';
import '../../data/models/message_model.dart';
import '../../data/repository/chat_repository_impl.dart';
import '../../domain/repository/chat_repository.dart';
import 'chat_provider.dart';

final messageProvider = AsyncNotifierProvider.autoDispose.family(() {
  return MessageProvider.new();
});

final messageFileProvider = StateProvider<File?>((ref) {
  return null;
});

class MessageProvider
    extends AutoDisposeFamilyAsyncNotifier<MessageState, int> {
  late final ChatRepository _chatRepository;
  StreamSubscription<MessageModel>? _messageSubscription;
  late final UserModel _currentUser;
  late final int roomId;

  @override
  Future<MessageState> build(int roomId) async {
    this.roomId = roomId;
    _chatRepository = ref.watch(chatRepositoryProvider);

    _currentUser = ref.watch(userProvider)!;
    final messages = await getRoomMessages();

    // messageStream = _chatRepository.listenToNewMessages();
    if (_messageSubscription == null) {
      _messageSubscription = _chatRepository.listenToNewMessages().listen((
        newMessage,
      ) {
        if (newMessage.roomId != roomId) {
          print("message is not for this room");
          return;
        }
        print("new message received in stream: $newMessage");
        final messages = state.value?.messages ?? [];
        final messagesId = messages.map((message) => message.id).toList();

        if (messagesId.contains(newMessage.id)) {
          // update
          final index = messagesId.indexOf(newMessage.id);
          state = AsyncData(
            MessageState(
              isLoading: state.value!.isLoading,
              messages: [
                ...(List.from(state.value?.messages ?? []))..removeAt(index),
              ]..insert(index, newMessage),
            ),
          );
        } else {
          // insert
          if (newMessage.senderId != ref.read(userProvider)!.id) {
            ref.read(roomProvider.notifier).markAllMyMessageAsRead(roomId);
          }

          state = AsyncData(
            MessageState(
              isLoading: state.value!.isLoading,
              messages: [newMessage, ...state.value?.messages ?? []],
            ),
          );
        }
      });
    }

    ref.onDispose(() {
      _messageSubscription?.cancel();
    });

    return MessageState(isLoading: false, messages: messages);
  }

  Future<void> sendMessage({
    required String message,
    File? messageImage,
  }) async {
    state = AsyncData(
      MessageState(isLoading: true, messages: state.value?.messages ?? []),
    );
    print(messageImage);
    final newMessage = MessageModel(
      id: Random().nextInt(100000),
      message: message,
      roomId: roomId,
      senderId: _currentUser.id,
      createdAt: DateTime.now().toUtc().toIso8601String(),
    );
    await _chatRepository.sendMessage(message: newMessage, file: messageImage);
    messageImage = null;
    state = AsyncData(
      MessageState(isLoading: false, messages: state.value?.messages ?? []),
    );
  }

  Future<List<MessageModel>> getRoomMessages() async {
    final response = await _chatRepository.getRoomMessages(roomId: roomId);

    if (response.isSuccess) {
      return response.data ?? [];
    }

    return Future.error(response.error ?? 'Unable to get room messages');
  }
}
