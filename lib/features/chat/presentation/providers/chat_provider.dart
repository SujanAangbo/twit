import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/chat/data/models/room_model.dart';
import 'package:twit/features/chat/data/repository/chat_repository_impl.dart';
import 'package:twit/features/chat/domain/repository/chat_repository.dart';

final getAllRoomProvider = FutureProvider((ref) {
  return ref.watch(roomProvider.notifier).getUserChatRoom();
});

final roomChangeProvider = StreamProvider((ref) {
  return ref.watch(roomProvider.notifier).listenToRoomChanges();
});

final getChatRoomWithUserProvider = FutureProviderFamily((
  ref,
  String friendUserId,
) {
  final user = ref.watch(userProvider)!;
  return ref.watch(roomProvider.notifier).getChatRoomWithUser([
    user.id,
    friendUserId,
  ]);
});

final roomProvider = AsyncNotifierProvider(() => RoomProvider.new());

class RoomProvider extends AsyncNotifier<List<RoomModel>> {
  late final ChatRepository _chatRepository;
  late final UserModel _currentUser;
  late StreamSubscription<RoomModel>? _roomStream;

  @override
  Future<List<RoomModel>> build() async {
    _chatRepository = ref.watch(chatRepositoryProvider);
    _currentUser = ref.watch(userProvider)!;

    _roomStream = _chatRepository.listenToRoomChange().listen((newRoom) {
      final rooms = List<RoomModel>.from(state.value ?? []);
      final roomIds = rooms.map((room) => room.id).toList();

      if (!newRoom.members.contains(_currentUser.id)) {
        return;
      }

      if (roomIds.contains(newRoom.id)) {
        final index = roomIds.indexOf(newRoom.id);
        rooms[index] = newRoom;
        rooms.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      } else {
        rooms.insert(0, newRoom);
      }

      state = AsyncData(rooms);
    });

    ref.onDispose(() {
      _roomStream?.cancel();
    });

    return await getUserChatRoom();
  }

  Future<List<RoomModel>> getUserChatRoom() async {
    final response = await _chatRepository.getUserChatRoom(_currentUser.id);

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
    await _chatRepository.markAllMessageAsRead(
      userId: _currentUser.id,
      roomId: roomId,
    );
  }

  Stream<RoomModel> listenToRoomChanges() {
    return _chatRepository.listenToRoomChange();
  }
}
