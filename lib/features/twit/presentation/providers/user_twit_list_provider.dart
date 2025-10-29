import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums/twit_status_enum.dart';
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

    _twitRepository.listenToNewUserTwit(userId).listen((newTwit) {
      final currentData = List<TwitModel>.from(state.value ?? []);
      final currentDataIds = currentData.map((twit) => twit.id).toList();

      if (newTwit.event == TwitEventType.CREATE) {
        currentData.insert(0, newTwit);
      } else if (newTwit.event == TwitEventType.UPDATE) {
        final index = currentDataIds.indexOf(newTwit.id);
        currentData[index] = newTwit;
      } else if (newTwit.event == TwitEventType.DELETE) {
        final index = currentDataIds.indexOf(newTwit.id);
        currentData.removeAt(index);
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
