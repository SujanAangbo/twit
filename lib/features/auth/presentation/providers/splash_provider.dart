import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/services/local/local_user_service.dart';

final splashProvider = StateNotifierProvider<SplashProvider, UserModel?>((ref) {
  return SplashProvider(localUserService: ref.watch(localUserService));
});

class SplashProvider extends StateNotifier<UserModel?> {
  SplashProvider({required LocalUserService localUserService})
    : _localUserService = localUserService,
      super(null) {
    isAuthenticated();
  }

  final LocalUserService _localUserService;

  Future<void> isAuthenticated() async {
    final result = await _localUserService.getLocalUser();

    if (result.isSuccess &&
        Supabase.instance.client.auth.currentSession != null) {
      state = result.data;
    } else {
      state = null;
    }
  }
}
