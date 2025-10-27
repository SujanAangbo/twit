import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/search/presentation/providers/search_provider.dart';
import 'package:twit/features/search/presentation/widgets/search_loader_widget.dart';
import 'package:twit/features/search/presentation/widgets/user_list_tile.dart';
import 'package:twit/utils/ui/default_app_bar.dart';

import '../widgets/custom_search.dart';
import '../widgets/filter_widget.dart';

@RoutePage()
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);
    final provider = ref.watch(searchProvider.notifier);

    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          title: "People",
          action: Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(Icons.search_rounded, size: 28),
              onPressed: () async {
                final searchText = await showSearch(
                  context: context,
                  delegate: CustomSearch(),
                  query: provider.getText,
                );
                provider.setText(searchText ?? '');
              },
            ),
          ),
          leading: const SizedBox.shrink(),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (provider.getText.isNotEmpty) FilterWidget(),
            Expanded(
              child: state.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.grey[800]?.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person_search_rounded,
                              size: 64,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'No users found',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[400],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            provider.getText.isNotEmpty
                                ? 'Try searching for something else'
                                : 'Start searching to find people',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: data.length,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return UserListTile(user: data[index]);
                    },
                    separatorBuilder: (context, int index) {
                      return Divider(
                        height: 1,
                        thickness: 0.5,
                        color: Colors.grey[800],
                      );
                    },
                  );
                },
                error: (err, st) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.error_outline_rounded,
                            size: 64,
                            color: Colors.red[400],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Oops! Something went wrong',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            err.toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                loading: () {
                  return SearchLoaderWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
