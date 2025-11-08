import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/core/response/result.dart';
import 'package:twit/features/chat/data/models/message_model.dart';
import 'package:twit/features/chat/data/models/room_model.dart';
import 'package:twit/features/chat/domain/repository/chat_repository.dart';
import 'package:twit/services/remote/chat_service.dart';
import 'package:twit/services/remote/storage_service.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepositoryImpl(
    chatService: ref.watch(chatServiceProvider),
    storageService: ref.watch(storageServiceProvider),
  ),
);

class ChatRepositoryImpl implements ChatRepository {
  final ChatService _chatService;
  final StorageService _storageService;

  final StreamController<MessageModel> _messageStream =
      StreamController.broadcast();
  final StreamController<RoomModel> _roomStream = StreamController.broadcast();

  ChatRepositoryImpl({
    required ChatService chatService,
    required StorageService storageService,
  }) : _chatService = chatService,
       _storageService = storageService;

  @override
  Future<Result<RoomModel>> getChatRoom(List<String> usersId) async {
    try {
      final result = await _chatService.getChatRoom(usersId);

      if (result == null) {
        return Result.error("Unable to create chat room");
      } else {
        return Result.success(result);
      }
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<List<MessageModel>>> getRoomMessages({
    required int roomId,
  }) async {
    try {
      final result = await _chatService.getRoomMessages(roomId);
      return Result.success(result);
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<bool>> sendMessage({
    required MessageModel message,
    File? file,
  }) async {
    try {
      String? imagePath;
      if (file != null) {
        imagePath = await _storageService.insertImage(file);
      }

      await _chatService.createMessage(message.copyWith(image: imagePath));
      return Result.success(true);
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<List<RoomModel>>> getUserChatRoom(String userId) async {
    try {
      final result = await _chatService.getUserChatRoom(userId);
      return Result.success(result);
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<bool>> markAllMessageAsRead({
    required String userId,
    required int roomId,
  }) async {
    try {
      final result = await _chatService.markAllMyMessageAsRead(userId, roomId);
      return Result.success(true);
    } on PostgrestException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Stream<MessageModel> listenToNewMessages() {
    _chatService.listenToNewMessage((payload) {
      if (payload.eventType == PostgresChangeEvent.insert ||
          payload.eventType == PostgresChangeEvent.update) {
        final message = MessageModel.fromJson(payload.newRecord);
        _messageStream.add(message);
      }
    });
    return _messageStream.stream;
  }

  @override
  Stream<RoomModel> listenToRoomChange() {
    _chatService.listenToRoomChange((payload) {
      if (payload.eventType == PostgresChangeEvent.insert ||
          payload.eventType == PostgresChangeEvent.update) {
        final room = RoomModel.fromJson(payload.newRecord);

        if (room.lastSender == null) {
          return;
        }
        _roomStream.add(room);
      }
    });
    return _roomStream.stream;
  }
}
