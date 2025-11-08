import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/features/chat/data/models/message_model.dart';
import 'package:twit/features/chat/data/models/room_model.dart';

import '../../core/constants/supabase_constants.dart';

final chatServiceProvider = Provider((ref) => ChatService());

class ChatService {
  final _supabase = Supabase.instance.client;
  RealtimeChannel? _messageStream;
  RealtimeChannel? _roomStream;

  Future<void> createMessage(MessageModel message) async {
    await _supabase
        .from(SupabaseConstants.messageTable)
        .insert(message.toJson()..remove('id'));
    await _supabase
        .from(SupabaseConstants.roomTable)
        .update({
          'last_message': message.message,
          'last_sender': message.senderId,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', message.roomId);
    await _supabase.rpc(
      'increment_unread_count',
      params: {'room_id': message.roomId},
    );
  }

  Future<List<MessageModel>> getRoomMessages(int roomId) async {
    final result = await _supabase
        .from(SupabaseConstants.messageTable)
        .select()
        .eq('room_id', roomId)
        .order('created_at');

    if (result.isNotEmpty) {
      final messages = result
          .map((element) => MessageModel.fromJson(element))
          .toList();
      return messages;
    } else {
      return [];
    }
  }

  Future<RoomModel?> createChatRoom(List<String> users) async {
    final newRoom = RoomModel(
      id: Random().nextInt(10000),
      members: users,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    final result = await _supabase
        .from(SupabaseConstants.roomTable)
        .insert(newRoom.toJson()..remove('id'))
        .select();

    if (result.isNotEmpty) {
      final room = result
          .map((element) => RoomModel.fromJson(element))
          .toList();
      return room.first;
    } else {
      return null;
    }
  }

  Future<RoomModel?> getChatRoom(List<String> usersId) async {
    final roomResponse = await _supabase
        .from(SupabaseConstants.roomTable)
        .select()
        .contains('members', usersId)
        .order('updated_at');

    if (roomResponse.isNotEmpty) {
      final rooms = roomResponse
          .map((element) => RoomModel.fromJson(element))
          .toList();
      return rooms.first;
    }

    return await createChatRoom(usersId);
  }

  Future<List<RoomModel>> getUserChatRoom(String userId) async {
    final roomResponse = await _supabase
        .from(SupabaseConstants.roomTable)
        .select()
        .contains('members', [userId])
        .not('last_sender', 'is', null)
        .order('updated_at');

    if (roomResponse.isNotEmpty) {
      final rooms = roomResponse
          .map((element) => RoomModel.fromJson(element))
          .toList();
      return rooms;
    }

    return [];
  }

  Future<void> markAllMyMessageAsRead(String userId, int roomId) async {
    await _supabase
        .from(SupabaseConstants.messageTable)
        .update({'is_seen': true})
        .eq('room_id', roomId)
        .eq('is_seen', false)
        .not('sender_id', 'eq', userId);
    await _supabase
        .from(SupabaseConstants.roomTable)
        .update({'unread_count': 0})
        .eq("id", roomId);
  }

  RealtimeChannel listenToNewMessage(
    void Function(PostgresChangePayload) callback,
  ) {
    if (_messageStream == null) {
      _messageStream = _supabase
          .channel('message_channel')
          .onPostgresChanges(
            event: PostgresChangeEvent.all,
            table: SupabaseConstants.messageTable,
            schema: 'public',
            callback: callback,
          )
          .subscribe();
    }

    return _messageStream!;
  }

  RealtimeChannel listenToRoomChange(
    void Function(PostgresChangePayload) callback,
  ) {
    if (_roomStream == null) {
      _roomStream = _supabase
          .channel('room_channel')
          .onPostgresChanges(
            event: PostgresChangeEvent.all,
            table: SupabaseConstants.roomTable,
            schema: 'public',
            callback: callback,
          )
          .subscribe();
    }

    return _roomStream!;
  }

  void closeChatStream() {
    _messageStream?.unsubscribe();
    _roomStream?.unsubscribe();
  }
}
