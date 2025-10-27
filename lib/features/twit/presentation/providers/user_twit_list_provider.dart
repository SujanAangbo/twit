import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/twit_model.dart';
import '../../data/repository/twit_repository_impl.dart';
import '../../domain/repository/twit_repository.dart';

final userTwitProvider =
    AsyncNotifierProviderFamily<UserTwitListProvider, List<TwitModel>, String>(
      () => UserTwitListProvider.new(),
    );

class UserTwitListProvider
    extends FamilyAsyncNotifier<List<TwitModel>, String> {
  late final TwitRepository _twitRepository;

  @override
  Future<List<TwitModel>> build(String userId) async {
    _twitRepository = ref.watch(twitRepositoryProvider);

    _twitRepository.listenToNewTwit(userId).listen((newTwit) {
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

    return await getUserTwits(userId);
  }

  Future<List<TwitModel>> getUserTwits(String userId) async {
    final response = await _twitRepository.getUserTwits(userId: userId);

    if (response.isSuccess) {
      return response.data ?? [];
    } else {
      return Future.error(response.error ?? 'Unable to fetch user twits');
    }
  }
}
