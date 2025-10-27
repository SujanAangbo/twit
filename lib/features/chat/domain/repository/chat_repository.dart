import 'dart:io';

import 'package:twit/core/response/result.dart';
import 'package:twit/features/chat/data/models/message_model.dart';

import '../../data/models/room_model.dart';

abstract class ChatRepository {
  Future<Result<RoomModel>> getChatRoom(List<String> usersId);

  Future<Result<List<RoomModel>>> getUserChatRoom(String userId);

  Future<Result<List<MessageModel>>> getRoomMessages({required int roomId});

  Future<Result<bool>> sendMessage({required MessageModel message, File? file});

  Future<Result<bool>> markAllMessageAsRead({
    required String userId,
    required int roomId,
  });

  Stream<MessageModel> listenToNewMessages();

  Stream<RoomModel> listenToRoomChange();
}
