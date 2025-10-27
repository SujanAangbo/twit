import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/search/domain/repository/search_repository.dart';

import '../../../auth/data/models/user_model.dart';
import '../../data/repository/search_repository_impl.dart';

final searchProvider = AsyncNotifierProvider<SearchProvider, List<UserModel>>(
  () => SearchProvider.new(),
);

class SearchProvider extends AsyncNotifier<List<UserModel>> {
  late final SearchRepository _searchRepository;
  final TextEditingController _searchController = TextEditingController();

  @override
  Future<List<UserModel>> build() async {
    _searchRepository = ref.watch(searchRepositoryProvider);

    _searchController.addListener(() async {
      state = AsyncLoading();
      final filteredUsers = await getUserByName();
      state = AsyncData(filteredUsers);
    });

    return await getUserByName();
  }

  Future<List<UserModel>> getUserByName() async {
    final searchText = _searchController.text.trim();
    final response = await _searchRepository.getUserByName(searchText);
    if (response.isSuccess) {
      return response.data!;
    } else {
      return Future.error(response.error ?? 'Unable to users');
    }
  }

  void setText(String text) {
    _searchController.text = text.trim();
  }

  String get getText => _searchController.text.trim();
}
