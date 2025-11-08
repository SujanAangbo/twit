import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/app/routes/app_route.gr.dart';
import 'package:twit/core/constants/constants.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/chat/data/models/room_model.dart';
import 'package:twit/features/chat/presentation/providers/chat_provider.dart';
import 'package:twit/features/profile/presentation/providers/profile_provider.dart';
import 'package:twit/features/twit/presentation/providers/user_twit_list_provider.dart';
import 'package:twit/theme/color_palette.dart';
import 'package:twit/utils/ui/app_cached_network_image.dart';
import 'package:twit/utils/ui/app_horizontal_divider.dart';
import 'package:twit/utils/ui/default_app_bar.dart';
import 'package:twit/utils/ui/primary_button.dart';
import 'package:twit/utils/ui/sized_box.dart';

import '../../../twit/presentation/widgets/twit_card.dart';
import '../../../twit/presentation/widgets/twit_list_shimmer.dart';
import '../widgets/follower_count_widget.dart';

@RoutePage()
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key, required this.user});

  // final String userId;
  final UserModel user;

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late UserModel user;

  @override
  void initState() {
    checkIsMyProfile();
    super.initState();
  }

  void checkIsMyProfile() {
    final myId = ref.read(userProvider)!.id;

    if (myId == widget.user.id) {
      print("my profile");
      user = ref.read(userProvider)!;
    } else {
      print("others profile");

      user = widget.user;
    }
  }

  bool get isMyProfile {
    final myId = ref.read(userProvider)!.id;

    if (widget.user.id.compareTo(myId) == 0) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(userProvider);
    final state = ref.watch(profileProvider(user));
    final provider = ref.watch(profileProvider(user).notifier);
    final twitProvider = ref.watch(userTwitProvider(user.id));

    final AsyncValue<RoomModel>? chatState;

    if (!isMyProfile) {
      chatState = ref.watch(getChatRoomWithUserProvider(user.id));
    } else {
      chatState = null;
    }

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: AppIconButton(
                icon: Icons.arrow_back,
                onPressed: () {
                  context.router.maybePop();
                },
              ),
              // leading: InkWell(
              //   onTap: () {
              //     context.router.maybePop();
              //   },
              //   child: Container(
              //     margin: EdgeInsets.only(top: 4, left: 8, bottom: 4),
              //     decoration: BoxDecoration(
              //       color: Colors.black.withAlpha(80),
              //       shape: BoxShape.circle,
              //     ),
              //     child: Icon(Icons.arrow_back, color: Colors.white),
              //   ),
              // ),
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  // How tall the appbar currently is
                  final appBarHeight = constraints.biggest.height;

                  // Decide threshold: when collapsed enough, hide content
                  final isCollapsed = appBarHeight < kToolbarHeight + 50;

                  return FlexibleSpaceBar(
                    title: isCollapsed
                        ? Text(
                            state.value?.user.fullName ?? '',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        : null,
                    background: Stack(
                      // fit: StackFit.passthrough,
                      clipBehavior: Clip.none,
                      children: [
                        // AppCachedNetworkImage(imageUrl: "", height: 140),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: state.value?.user.bannerPicture == null
                                ? ColorPalette.blueColor
                                : null,
                          ),
                          child: state.value?.user.bannerPicture == null
                              ? null
                              : AppCachedNetworkImage(
                                  imageUrl:
                                      '${SupabaseConstants.storagePath}${state.value?.user.bannerPicture}',
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        if (!isCollapsed)
                          Positioned(
                            bottom: 0,
                            left: 16,
                            child: AppCachedNetworkImage(
                              imageUrl: state.value?.user.profilePicture == null
                                  ? AppAssets.profileNetwork
                                  : state.value!.user.profilePicture!
                                        .startsWith('http')
                                  ? state.value!.user.profilePicture!
                                  : '${SupabaseConstants.storagePath}${state.value?.user.profilePicture}',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              isRounded: true,
                            ),
                          ),
                        if (!isCollapsed)
                          Positioned(
                            bottom: 0,
                            right: 16,
                            child: PrimaryButton(
                              width: 140,
                              isLoading: state.value?.isFollowing == null,
                              backgroundColor:
                                  (state.value?.isFollowing ?? false)
                                  ? ColorPalette.greyColor
                                  : null,
                              borderColor: (state.value?.isFollowing ?? false)
                                  ? ColorPalette.greyColor
                                  : null,
                              text: isMyProfile
                                  ? "Edit Profile"
                                  : (state.value?.isFollowing ?? false)
                                  ? 'Following'
                                  : 'Follow',
                              onPressed: () async {
                                if (isMyProfile) {
                                  await context.router.push(
                                    EditProfileRoute(user: state.value!.user),
                                  );
                                  checkIsMyProfile();
                                  setState(() {});
                                } else {
                                  // follow work
                                  print(
                                    "stateee: " +
                                        state.value!.isFollowing.toString(),
                                  );
                                  final currentUser = ref.read(userProvider)!;
                                  provider.followUser(
                                    currentUser: currentUser,
                                    otherUser: state.value!.user,
                                  );
                                }
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(8),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.value?.user.fullName ?? '',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      4.heightBox,
                      Text(
                        "@${state.value?.user.fullName.toLowerCase() ?? ''}",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontSize: 18,
                              color: ColorPalette.greyColor,
                            ),
                      ),
                      8.heightBox,
                      Text(
                        state.value?.user.bio ?? '',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(fontSize: 18),
                      ),
                      8.heightBox,
                      Row(
                        children: [
                          FollowerCountWidget(
                            count: state.value?.user.followingCount ?? 0,
                            text: "Following",
                          ),
                          16.widthBox,
                          FollowerCountWidget(
                            count: state.value?.user.followersCount ?? 0,
                            text: "Followers",
                          ),
                        ],
                      ),
                      16.heightBox,
                      if (!isMyProfile) ...[
                        PrimaryButton(
                          text: "Send message",
                          isLoading: chatState!.isLoading,
                          onPressed: () {
                            if (!chatState!.isLoading) {
                              print(chatState.value);
                              context.router.push(
                                MessageRoute(room: chatState.value!),
                              );
                            }
                            // chatState.whenData((data) {
                            //   context.router.push(MessageRoute(room: data));
                            // });
                          },
                        ),
                        16.heightBox,
                      ],

                      Text(
                        'Posts: ',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppHorizontalDivider(height: 16),

                      twitProvider.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: Text("No Twits Posted")),
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
                          return TwitListShimmer();
                        },
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
