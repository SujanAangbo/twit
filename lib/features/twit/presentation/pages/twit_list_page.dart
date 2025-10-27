import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twit/core/constants/app_assets.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/twit/presentation/providers/twit_list_provider.dart';
import 'package:twit/theme/color_palette.dart';

import '../../../../core/constants/supabase_constants.dart';
import '../../../../utils/ui/app_cached_network_image.dart';
import '../widgets/twit_card.dart';
import '../widgets/twit_list_shimmer.dart';

@RoutePage()
class TwitListPage extends ConsumerWidget {
  const TwitListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Enhanced App Bar
          SliverAppBar(
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile Picture
                  currentUser == null
                      ? Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: AppCachedNetworkImage(
                              imageUrl: currentUser.profilePicture == null
                                  ? AppAssets.profileNetwork
                                  : '${SupabaseConstants.storagePath}${currentUser.profilePicture}',
                              height: 40,
                              width: 40,
                              isRounded: true,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                  // Twitter Logo
                  Hero(
                    tag: 'twitter_logo',
                    child: SvgPicture.asset(
                      AppAssets.twitterLogo,
                      height: 32,
                      width: 32,
                      colorFilter: ColorFilter.mode(
                        ColorPalette.blueColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  // Placeholder for symmetry
                  SizedBox(width: 40),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.grey.withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.only(top: 8),
            sliver: ref
                .watch(twitListProvider)
                .when(
                  data: (data) {
                    if (data.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.article_outlined,
                                size: 80,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No tweets yet',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: Colors.grey.withOpacity(0.5),
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'When tweets are posted, they\'ll show up here',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey.withOpacity(0.4),
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: 1.0,
                          child: TwitCard(twit: data[index]),
                        );
                      }, childCount: data.length),
                    );
                  },
                  error: (err, st) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.all(24),
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.red.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red.shade300,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Something went wrong',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Colors.red.shade300,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                err.toString(),
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.red.shade200),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  loading: () {
                    return SliverToBoxAdapter(child: TwitListShimmer());
                  },
                ),
          ),
        ],
      ),
    );
  }
}
