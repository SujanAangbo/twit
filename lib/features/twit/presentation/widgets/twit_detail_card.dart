import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:twit/app/routes/app_route.gr.dart';
import 'package:twit/core/common/date_formatter.dart';
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

class TwitDetailCard extends ConsumerWidget {
  final TwitModel twit;

  const TwitDetailCard({super.key, required this.twit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);
    return ref
        .watch(userDetailProvider(twit.userId))
        .when(
          data: (user) {
            print(user);
            return Column(
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
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  8.heightBox,
                ],

                InkWell(
                  onTap: () {
                    context.router.push(ProfileRoute(user: user!));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppCachedNetworkImage(
                        imageUrl: user?.profilePicture == null
                            ? AppAssets.profileNetwork
                            : user!.profilePicture!.startsWith('http')
                            ? user.profilePicture!
                            : '${SupabaseConstants.storagePath}${user.profilePicture}',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        isRounded: true,
                      ),
                      8.widthBox,
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.fullName ?? 'Unknown User',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(fontSize: 20),
                              ),
                              Text(
                                '@${user?.fullName.toLowerCase() ?? 'unknown'}',
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(color: ColorPalette.greyColor),
                              ),
                            ],
                          ),
                          4.widthBox,
                        ],
                      ),
                      4.heightBox,
                    ],
                  ),
                ),

                8.heightBox,

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ui for retwited twit

                    // for twit ui
                    if (twit.replyTo != null)
                      ref
                          .watch(userDetailProvider(twit.replyTo!))
                          .when(
                            data: (replyUser) {
                              return InkWell(
                                onTap: () {
                                  context.router.push(
                                    ProfileRoute(user: replyUser!),
                                  );
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Replying to ',
                                    children: [
                                      TextSpan(
                                        text: replyUser?.fullName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: ColorPalette.blueColor,
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
                    8.heightBox,
                    Text(
                      DateFormatter.formatDateTime(
                        DateTime.parse(twit.createdAt!).toLocal(),
                      ),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: ColorPalette.greyColor,
                      ),
                    ),
                    8.heightBox,

                    // reaction widgets => like, comment, etc.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TwitIconButton(
                          iconPath: AppAssets.viewsIcon,
                          value:
                              (twit.likes.length +
                                      twit.comments.length +
                                      twit.shareCount)
                                  .toString(),
                          onPressed: () {},
                        ),
                        TwitIconButton(
                          iconPath: AppAssets.commentIcon,
                          value: twit.comments.length.toString(),
                          onPressed: () {},
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
                            twit.copyWith(likes: likes);
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
                          onPressed: () {},
                          icon: Icon(Icons.share_outlined, size: 24),
                        ),
                      ],
                    ),
                  ],
                ),
                8.heightBox,
                AppHorizontalDivider(),
              ],
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
        );
  }
}
