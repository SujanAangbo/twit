import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/chat/data/models/message_model.dart';
import 'package:twit/features/chat/data/models/room_model.dart';
import 'package:twit/features/chat/data/repository/chat_repository_impl.dart';
import 'package:twit/features/chat/domain/repository/chat_repository.dart';

final roomMessagesProvider = FutureProviderFamily((ref, int roomId) {
  return ref.watch(chatProvider.notifier).getRoomMessages(roomId);
});

final getAllRoomProvider = FutureProvider((ref) {
  final user = ref.watch(userProvider)!;
  return ref.watch(chatProvider.notifier).getUserChatRoom(user.id);
});

// final newMessageStreamProvider = StreamProvider<MessageModel>((ref) {
//   return ref.read(chatProvider.notifier).listenToNewMessages();
// });

final roomChangeProvider = StreamProvider((ref) {
  return ref.watch(chatProvider.notifier).listenToRoomChanges();
});

final getChatRoomWithUserProvider = FutureProviderFamily((
  ref,
  String friendUserId,
) {
  final user = ref.watch(userProvider)!;
  return ref.watch(chatProvider.notifier).getChatRoomWithUser([
    user.id,
    friendUserId,
  ]);
});

final chatProvider = StateNotifierProvider(
  (ref) => ChatProvider(
    chatRepository: ref.watch(chatRepositoryProvider),
    currentUser: ref.watch(userProvider)!,
  ),
);

final messageProvider = AsyncNotifierProvider.autoDispose.family(() {
  return MessageProvider.new();
});

final messageFileProvider = StateProvider<File?>((ref) {
  return null;
});

class MessageProvider
    extends AutoDisposeFamilyAsyncNotifier<List<MessageModel>, int> {
  late final ChatRepository _chatRepository;
  late StreamSubscription<MessageModel>? _messageSubscription;

  @override
  Future<List<MessageModel>> build(int roomId) async {
    print("ref initiated");

    _chatRepository = ref.watch(chatRepositoryProvider);
    final provider = ref.watch(chatProvider.notifier);
    final messages = await provider.getRoomMessages(roomId);

    // messageStream = _chatRepository.listenToNewMessages();
    _messageSubscription = _chatRepository.listenToNewMessages().listen((
      newMessage,
    ) {
      // do the thing
      print("new message received in listener $newMessage");

      final messages = state.value ?? [];
      final messagesId = messages.map((message) => message.id).toList();

      if (messagesId.contains(newMessage.id)) {
        // update
        print("message seen: $newMessage");
        final index = messagesId.indexOf(newMessage.id);
        state = AsyncData(
          [...(state.value ?? [])..removeAt(index)]..insert(index, newMessage),
        );
      } else {
        // insert
        print("adding new message: $newMessage");

        if (newMessage.senderId != ref.read(userProvider)!.id) {
          print("marking all my notification as read");
          ref.read(chatProvider.notifier).markAllMyMessageAsRead(roomId);
        }

        state = AsyncData([newMessage, ...state.value ?? []]);
      }
    });
    ref.onDispose(() {
      print("ref disposed");
      _messageSubscription?.cancel();
    });

    return messages;
  }
}

class ChatProvider extends StateNotifier<bool> {
  ChatProvider({
    required ChatRepository chatRepository,
    required UserModel currentUser,
  }) : _chatRepository = chatRepository,
       _currentUser = currentUser,
       super(false) {}

  final ChatRepository _chatRepository;
  final UserModel _currentUser;

  Future<void> sendMessage({
    required String message,
    required int roomId,
    File? messageImage,
  }) async {
    state = true;
    print(messageImage);
    final newMessage = MessageModel(
      id: Random().nextInt(100000),
      message: message,
      roomId: roomId,
      senderId: _currentUser.id,
      createdAt: DateTime.now().toIso8601String(),
    );
    await _chatRepository.sendMessage(message: newMessage, file: messageImage);
    messageImage = null;
    state = false;
  }

  Future<List<MessageModel>> getRoomMessages(int roomId) async {
    final response = await _chatRepository.getRoomMessages(roomId: roomId);

    if (response.isSuccess) {
      return response.data ?? [];
    }

    return Future.error(response.error ?? 'Unable to get room messages');
  }

  Future<List<RoomModel>> getUserChatRoom(String userId) async {
    final response = await _chatRepository.getUserChatRoom(userId);

    if (response.isSuccess) {
      return response.data ?? [];
    }

    return Future.error(response.error ?? 'Unable to get rooms');
  }

  Future<RoomModel> getChatRoomWithUser(List<String> usersId) async {
    final response = await _chatRepository.getChatRoom(usersId);

    if (response.isSuccess) {
      return response.data!;
    }

    return Future.error(response.error ?? 'Unable to get room');
  }

  Future<void> markAllMyMessageAsRead(int roomId) async {
    print("reading all messages");
    await _chatRepository.markAllMessageAsRead(
      userId: _currentUser.id,
      roomId: roomId,
    );
  }

  // Stream<MessageModel> listenToNewMessages() {
  //   return _chatRepository.listenToNewMessages();
  // }

  Stream<RoomModel> listenToRoomChanges() {
    return _chatRepository.listenToRoomChange();
  }
}
