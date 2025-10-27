import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/twit/presentation/providers/twit_list_provider.dart';
import 'package:twit/utils/ui/default_app_bar.dart';

import '../widgets/twit_card.dart';

@RoutePage()
class HashtagPage extends ConsumerWidget {
  const HashtagPage({super.key, required this.hashtag});

  final String hashtag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: DefaultAppBar(title: hashtag),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ref
              .watch(getTwitByHashtagProvider(hashtag))
              .when(
                data: (data) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: TwitCard(twit: data[index]),
                      );
                    },
                  );
                },
                error: (err, st) {
                  return Center(
                    child: Text(
                      err.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
                loading: () {
                  return Center(child: CircularProgressIndicator());
                },
              ),
        ),
      ),
    );
  }
}
