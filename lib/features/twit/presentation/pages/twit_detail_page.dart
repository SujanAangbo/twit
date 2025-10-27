import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/twit/data/models/twit_model.dart';
import 'package:twit/utils/ui/focus_scaffold.dart';
import 'package:twit/utils/ui/sized_box.dart';

import '../../../../utils/ui/default_app_bar.dart';
import '../providers/comment_provider.dart';
import '../widgets/create_twit_comment_form.dart';
import '../widgets/twit_card.dart';
import '../widgets/twit_detail_card.dart';

@RoutePage()
class TwitDetailPage extends ConsumerWidget {
  TwitDetailPage({super.key, required this.twit});

  final TwitModel twit;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentState = ref.watch(twitCommentsProvider(twit.id));
    print(twit);

    return SafeArea(
      child: FocusScaffold(
        appBar: DefaultAppBar(
          title: "Post",
          centerTitle: true,
          hasBottomDivider: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TwitDetailCard(twit: twit),
                      12.heightBox,
                      Text(
                        "Comments: ",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      20.heightBox,
                      commentState.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: Text("No comments yet")),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            physics: NeverScrollableScrollPhysics(),
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
                    ],
                  ),
                ),
              ),
              CreateTwitCommentForm(twit: twit),
            ],
          ),
        ),
      ),
    );
  }
}
