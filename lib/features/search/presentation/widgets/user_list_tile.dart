import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:twit/app/routes/app_route.gr.dart';
import 'package:twit/core/constants/constants.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/utils/ui/app_cached_network_image.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.router.push(ProfileRoute(user: user));
      },
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 8,
      leading: AppCachedNetworkImage(
        imageUrl: user.profilePicture != null
            ? user.profilePicture!.startsWith('http')
                  ? user.profilePicture!
                  : '${SupabaseConstants.storagePath}/${user.profilePicture}'
            : '${AppAssets.profileNetwork}',
        isRounded: true,
        fit: BoxFit.cover,
        height: 80,
        width: 80,
      ),
      title: Text(user.fullName),
      subtitle: Text('@${user.fullName}'),
    );
  }
}
