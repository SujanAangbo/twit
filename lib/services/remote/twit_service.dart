import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/core/constants/constants.dart';
import 'package:twit/features/twit/data/models/twit_model.dart';

final twitServiceProvider = Provider((ref) => TwitService());

class TwitService {
  final _supabase = Supabase.instance.client;

  RealtimeChannel? _twitStream;
  RealtimeChannel? _twitCommentStream;

  Future<void> createTwit(TwitModel twitModel) async {
    final data = twitModel.toJson();
    await _supabase.from(SupabaseConstants.twitTable).insert(data);
  }

  Future<List<TwitModel>> getAllTwit() async {
    final response = await _supabase
        .from(SupabaseConstants.twitTable)
        .select()
        .order('created_at', ascending: false);

    final twitList = response.map((e) => TwitModel.fromJson(e)).toList();
    return twitList;
  }

  Future<List<TwitModel>> getTwitByHashtag(String hashtag) async {
    final response = await _supabase
        .from(SupabaseConstants.twitTable)
        .select()
        .contains("hashtags", [hashtag]);

    final twitList = response.map((e) => TwitModel.fromJson(e)).toList();
    return twitList;
  }

  Future<TwitModel> getTwit(String twitId) async {
    final response = await _supabase
        .from(SupabaseConstants.twitTable)
        .select()
        .eq('id', twitId)
        .single();

    print("response: $response");

    return TwitModel.fromJson(response);
  }

  Future<List<TwitModel>> getUserTwits(String userId) async {
    final response = await _supabase
        .from(SupabaseConstants.twitTable)
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    final twitList = response.map((e) => TwitModel.fromJson(e)).toList();
    return twitList;
  }

  Future<List<TwitModel>> getTwitComments(String twitId) async {
    final response = await _supabase
        .from(SupabaseConstants.twitTable)
        .select()
        .eq('reply_twit_id', twitId)
        .order('created_at', ascending: false);

    final twitList = response.map((e) => TwitModel.fromJson(e)).toList();
    return twitList;
  }

  Future<void> deleteTwit(String id) async {
    await _supabase.from(SupabaseConstants.twitTable).delete().eq('id', id);
  }

  Future<void> updateTwit(TwitModel twitModel) async {
    final data = twitModel.toJson()..remove('id');
    await _supabase
        .from(SupabaseConstants.twitTable)
        .update(data)
        .eq('id', twitModel.id);
  }

  Future<void> toggleTwitLike(String twitId, List<String> likes) async {
    await _supabase
        .from(SupabaseConstants.twitTable)
        .update({'likes': likes})
        .eq('id', twitId);
  }

  Future<void> reTwit(TwitModel twit) async {
    await _supabase.from(SupabaseConstants.twitTable).insert(twit.toJson());
  }

  RealtimeChannel listenToNewTwit(
    void Function(PostgresChangePayload) callback,
  ) {
    _twitStream = _supabase
        .channel('twit_channel1')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          table: SupabaseConstants.twitTable,
          schema: 'public',
          callback: callback,
        )
        .subscribe();
    return _twitStream!;
  }

  RealtimeChannel listenToTwitComment(
    String twitId,
    void Function(PostgresChangePayload) callback,
  ) {
    _twitCommentStream = _supabase
        .channel('twit_comment_channel')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          table: SupabaseConstants.twitTable,
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'reply_twit_id',
            value: twitId,
          ),
          schema: 'public',
          callback: callback,
        )
        .subscribe();

    return _twitCommentStream!;
  }

  void closeTwitStream() {
    _twitStream?.unsubscribe();
    _twitCommentStream?.unsubscribe();
  }
}
