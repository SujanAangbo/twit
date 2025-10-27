import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:twit/utils/ui/sized_box.dart';

import '../../../../core/common/snackbar.dart';
import '../../../../theme/color_palette.dart';
import '../../../auth/presentation/providers/user_provider.dart';
import '../../data/models/twit_model.dart';
import '../providers/comment_provider.dart';
import '../providers/create_twit_provider.dart';

class CreateTwitCommentForm extends ConsumerWidget {
  CreateTwitCommentForm({super.key, required this.twit});

  final TwitModel twit;

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentProvider = ref.watch(twitCommentsProvider(twit.id).notifier);

    final createTwit = ref.watch(createTwitProvider);
    final provider = ref.watch(createTwitProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (createTwit.images.isNotEmpty) ...[
            Container(
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorPalette.greyColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      createTwit.images.first,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  12.widthBox,
                  Expanded(
                    child: Text(
                      path.basename(createTwit.images.first.path),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 20),
                    onPressed: () {
                      provider.removeImage(0);
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: ColorPalette.greyColor.withOpacity(0.2),
                      padding: EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorPalette.blueColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.image_outlined,
                      color: ColorPalette.blueColor,
                    ),
                    onPressed: () async {
                      provider.pickTwitImages(isMultiple: false);
                    },
                  ),
                ),
                12.widthBox,
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: ColorPalette.greyColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: commentController,
                      minLines: 1,
                      maxLines: 4,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: InputDecoration(
                        hintText: "Your comment...",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                12.widthBox,
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorPalette.blueColor,
                        ColorPalette.blueColor.withOpacity(0.8),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorPalette.blueColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: createTwit.isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 2,
                            padding: EdgeInsets.zero,
                          )
                        : Icon(Icons.send_rounded, color: Colors.white),
                    onPressed: () async {
                      final currentUser = ref.read(userProvider);
                      provider.loader = true;

                      final result = await commentProvider.createTwitComment(
                        commentController.text.trim(),
                        twit,
                        currentUser!,
                        createTwit.images.firstOrNull,
                      );

                      provider.loader = false;

                      if (result == true) {
                        commentController.clear();
                        ref.read(createTwitProvider.notifier).removeImage(0);
                        // showSnackBar(
                        //   context: context,
                        //   message: "Comment added successfully",
                        //   status: SnackBarStatus.success,
                        // );
                      } else {
                        showSnackBar(
                          context: context,
                          message: "Unable to comment",
                          status: SnackBarStatus.error,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
