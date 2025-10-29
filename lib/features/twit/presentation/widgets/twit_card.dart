import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:twit/app/routes/app_route.gr.dart';
import 'package:twit/core/constants/constants.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/twit/data/models/twit_model.dart';
import 'package:twit/theme/color_palette.dart';
import 'package:twit/utils/ui/app_cached_network_image.dart';
import 'package:twit/utils/ui/app_horizontal_divider.dart';
import 'package:twit/utils/ui/image_carousel.dart';
import 'package:twit/utils/ui/shimmer_scaffold.dart';
import 'package:twit/utils/ui/shimmer_skeleton.dart';
import 'package:twit/utils/ui/sized_box.dart';

import '../../../../../utils/ui/twit_icon_button.dart';
import '../providers/twit_list_provider.dart';
import 'hashtag_text.dart';

class TwitCard extends ConsumerWidget {
  TwitModel twit;

  TwitCard({super.key, required this.twit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);
    return ref
        .watch(userDetailProvider(twit.userId))
        .when(
          data: (user) {
            print(user);
            return InkWell(
              onTap: () {
                context.router.push(TwitDetailRoute(twit: twit));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  8.heightBox,
                  if (twit.isReposted) ...[
                    Row(
                      children: [
                        16.widthBox,
                        SvgPicture.asset(
                          AppAssets.retweetIcon,
                          color: Colors.grey,
                          height: 20,
                          width: 20,
                        ),
                        8.widthBox,
                        ref
                            .watch(userDetailProvider(twit.repostedUserId!))
                            .when(
                              data: (repostedUser) {
                                return Text(
                                  repostedUser?.fullName ?? 'Unknown User',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                );
                              },
                              error: (err, st) {
                                return SizedBox.shrink();
                              },
                              loading: () {
                                return ShimmerScaffold(
                                  child: Skeleton(height: 20, width: 200),
                                );
                              },
                            ),
                        8.widthBox,
                        Text(
                          'Retweeted',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    8.heightBox,
                  ],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          context.router.push(ProfileRoute(user: user!));
                        },
                        child: AppCachedNetworkImage(
                          imageUrl: user?.profilePicture == null
                              ? AppAssets.profileNetwork
                              : '${SupabaseConstants.storagePath}${user?.profilePicture}',
                          height: 50,
                          width: 50,
                          isRounded: true,
                          fit: BoxFit.cover,
                        ),
                      ),
                      8.widthBox,

                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // for twit ui
                            Row(
                              children: [
                                Text(
                                  user?.fullName ?? 'Unknown User',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontSize: 20),
                                ),
                                4.widthBox,
                                Text(
                                  '@${user?.fullName.toLowerCase() ?? 'unknown'}',
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(color: ColorPalette.greyColor),
                                ),
                                4.widthBox,
                                Text('•'),
                                Text(
                                  timeago.format(
                                    DateTime.parse(twit.createdAt!),
                                    locale: 'en_short',
                                  ),
                                ),
                                Expanded(child: SizedBox.shrink()),
                                if (currentUser?.id.compareTo(twit.userId) == 0)
                                  PopupMenuButton<String>(
                                    icon: Icon(Icons.more_vert),
                                    onSelected: (String value) {
                                      // Handle option click
                                      if (value == 'delete') {
                                        ref
                                            .read(twitListProvider.notifier)
                                            .deleteUserTwit(twit.id);
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                          PopupMenuItem<String>(
                                            value: 'delete',
                                            child: Text('Delete'),
                                          ),
                                        ],
                                  ),
                              ],
                            ),
                            4.heightBox,
                            if (twit.replyTo != null)
                              ref
                                  .watch(userDetailProvider(twit.replyTo!))
                                  .when(
                                    data: (replyUser) {
                                      return RichText(
                                        text: TextSpan(
                                          text: 'Replying to ',
                                          children: [
                                            TextSpan(
                                              text: replyUser?.fullName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    color:
                                                        ColorPalette.blueColor,
                                                  ),
                                            ),
                                          ],
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: ColorPalette.greyColor,
                                              ),
                                        ),
                                      );
                                    },
                                    error: (err, st) {
                                      return SizedBox.shrink();
                                    },
                                    loading: () {
                                      return ShimmerScaffold(
                                        child: Skeleton(height: 20, width: 200),
                                      );
                                    },
                                  ),
                            4.heightBox,
                            HashtagText(text: twit.content),

                            // Text(twit.content, style: Theme.of(context).textTheme.bodyLarge),
                            if (twit.images.isNotEmpty) ...[
                              4.heightBox,
                              ImageCarousel(
                                images: twit.images
                                    .map(
                                      (path) =>
                                          '${SupabaseConstants.storagePath}${path}',
                                    )
                                    .toList(),
                              ),
                            ],
                            4.heightBox,

                            // reaction widgets => like, comment, etc.
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TwitIconButton(
                                  iconPath: AppAssets.viewsIcon,
                                  value:
                                      (twit.likes.length +
                                              twit.comments.length +
                                              twit.shareCount)
                                          .toString(),
                                ),
                                TwitIconButton(
                                  iconPath: AppAssets.commentIcon,
                                  value: twit.comments.length.toString(),
                                  onPressed: () {
                                    context.router.push(
                                      TwitDetailRoute(twit: twit),
                                    );
                                  },
                                ),
                                TwitIconButton(
                                  iconPath: AppAssets.retweetIcon,

                                  value: twit.shareCount.toString(),
                                  onPressed: () {
                                    ref
                                        .read(twitListProvider.notifier)
                                        .reTwit(twit, currentUser!);
                                  },
                                ),
                                LikeButton(
                                  size: 24,
                                  likeCount: twit.likes.length,
                                  isLiked: twit.likes.contains(currentUser!.id),
                                  onTap: (isLiked) async {
                                    final likes = await ref
                                        .read(twitListProvider.notifier)
                                        .likeTwit(twit, currentUser);
                                    twit = twit.copyWith(likes: likes);
                                    return !isLiked;
                                  },
                                  likeBuilder: (isLiked) {
                                    return isLiked
                                        ? SvgPicture.asset(
                                            AppAssets.likeFilledIcon,
                                            colorFilter: ColorFilter.mode(
                                              ColorPalette.redColor,
                                              BlendMode.srcIn,
                                            ),
                                            height: 24,
                                            width: 24,
                                          )
                                        : SvgPicture.asset(
                                            AppAssets.likeOutlinedIcon,
                                            colorFilter: ColorFilter.mode(
                                              ColorPalette.greyColor,
                                              BlendMode.srcIn,
                                            ),
                                            height: 24,
                                            width: 24,
                                          );
                                  },
                                  countBuilder: (i, b, s) {
                                    return Text(i.toString());
                                  },
                                ),
                                IconButton(
                                  onPressed: () async {
                                    List<XFile>? files;

                                    final tempDir =
                                        await getTemporaryDirectory();

                                    if (twit.images.isNotEmpty) {
                                      files = await Future.wait(
                                        twit.images.map((image) async {
                                          final response = await http.get(
                                            Uri.parse(
                                              '${SupabaseConstants.storagePath}/${image}',
                                            ),
                                          );

                                          final file = File(
                                            '${tempDir.path}/${image.split('/').last}',
                                          );
                                          await file.writeAsBytes(
                                            response.bodyBytes,
                                          );
                                          return XFile(file.path);
                                        }).toList(),
                                      );
                                    }

                                    SharePlus.instance.share(
                                      ShareParams(
                                        text: twit.content,
                                        files: files,
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.share_outlined, size: 24),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  8.heightBox,
                  AppHorizontalDivider(),
                ],
              ),
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
            return ShimmerScaffold(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(height: 50, width: 50, isCircle: true),
                  8.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Skeleton(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 100,
                      ),
                      8.heightBox,
                      Skeleton(
                        height: 20,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      4.heightBox,
                      Skeleton(
                        height: 20,
                        width: MediaQuery.of(context).size.width / 2,
                      ),

                      8.heightBox,
                      Skeleton(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 100,
                      ),
                      16.heightBox,
                    ],
                  ),
                ],
              ),
            );
            // return Center(child: CircularProgressIndicator());
          },
        );
  }
}
