import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/app/routes/app_route.gr.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/theme/color_palette.dart';
import 'package:twit/utils/ui/app_horizontal_divider.dart';
import 'package:twit/utils/ui/sized_box.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/supabase_constants.dart';
import '../../../../core/supabase/supabase_instance.dart';
import '../../../../utils/ui/app_cached_network_image.dart';
import '../../../local_database/local_storage_service.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);

    if (currentUser == null) {
      return SizedBox();
    }

    return SafeArea(
      child: Drawer(
        backgroundColor: ColorPalette.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.heightBox,
              AppCachedNetworkImage(
                imageUrl: currentUser.profilePicture == null
                    ? AppAssets.profileNetwork
                    : '${SupabaseConstants.storagePath}${currentUser.profilePicture}',
                height: 60,
                width: 60,
                isRounded: true,
                fit: BoxFit.cover,
              ),
              16.heightBox,
              Text(
                currentUser.fullName,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              Text(
                "@${currentUser.fullName}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              16.heightBox,
              Row(
                children: [
                  Text("${currentUser.followersCount} Followers"),
                  16.widthBox,
                  Text("${currentUser.followersCount} Following"),
                ],
              ),

              AppHorizontalDivider(height: 32),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.person_outline),
                title: Text(
                  "Profile",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () {
                  context.router.push(ProfileRoute(user: currentUser));
                },
              ),
              // ListTile(
              //   contentPadding: EdgeInsets.zero,
              //   leading: Icon(Icons.workspace_premium),
              //   title: Text(
              //     "Premium",
              //     style: Theme.of(context).textTheme.titleMedium,
              //   ),
              //   onTap: () {
              //     // context.router.push(ProfileRoute(user: currentUser));
              //   },
              // ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.logout, color: ColorPalette.errorColor),
                title: Text(
                  "Logout",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: ColorPalette.errorColor,
                  ),
                ),
                onTap: () async {
                  /// 1. reset state
                  /// 2. clear local db
                  /// 3. logout from supabase
                  /// 4. navigate to login page

                  await ref.read(localStorageServiceProvider).clearUserData();
                  await supabaseClient.auth.signOut();
                  await context.router.pushAndPopUntil(
                    LoginRoute(),
                    predicate: (route) => false,
                  );
                  ref.read(userProvider.notifier).clearUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
