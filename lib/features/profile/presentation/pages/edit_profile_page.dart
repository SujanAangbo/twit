import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twit/core/common/image_picker_utils.dart';
import 'package:twit/core/constants/constants.dart';
import 'package:twit/features/auth/data/models/user_model.dart';
import 'package:twit/utils/ui/default_app_bar.dart';
import 'package:twit/utils/ui/focus_scaffold.dart';
import 'package:twit/utils/ui/primary_button.dart';
import 'package:twit/utils/ui/sized_box.dart';

import '../../../../theme/color_palette.dart';
import '../../../../utils/ui/app_cached_network_image.dart';
import '../providers/profile_provider.dart';

@RoutePage()
class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key, required this.user});

  final UserModel user;

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  late final TextEditingController nameController;
  late final TextEditingController bioController;

  File? profileImage;
  File? bannerImage;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.user.fullName.trim());
    bioController = TextEditingController(text: widget.user.bio?.trim());
    super.initState();
  }

  Future<void> pickProfileImage() async {
    print('clicked');
    final pickedImage = await ImagePickerUtil.pickImage(ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        profileImage = pickedImage;
      });
    }
  }

  Future<void> pickBannerImage() async {
    final pickedImage = await ImagePickerUtil.pickImage(ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        bannerImage = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider(widget.user));
    final provider = ref.watch(profileProvider(widget.user).notifier);

    return SafeArea(
      child: FocusScaffold(
        appBar: DefaultAppBar(
          title: 'Edit Profile',
          centerTitle: false,
          action: AppTextButton(
            isLoading: state.isLoading,
            text: 'Save',
            onPressed: () async {
              final response = await provider.editProfile(
                user: widget.user.copyWith(
                  fullName: nameController.text.trim(),
                  bio: bioController.text.trim(),
                ),
                profile: profileImage,
                banner: bannerImage,
              );
              print("response: $response");

              if (response) {
                context.router.pop();
              }

              // print("respose: $updatedUser");
              //
              // if (updatedUser != null) {
              //   await ref.read(userProvider.notifier).setUser(updatedUser);
              //   context.router.pop();
              // }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                child: Stack(
                  // fit: StackFit.passthrough,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: widget.user.bannerPicture == null
                            ? ColorPalette.blueColor
                            : null,
                      ),
                      child: bannerImage == null
                          ? widget.user.bannerPicture == null
                                ? null
                                : AppCachedNetworkImage(
                                    imageUrl:
                                        '${SupabaseConstants.storagePath}${widget.user.bannerPicture}',
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                          : Image.file(
                              bannerImage!,
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                    InkWell(
                      onTap: pickBannerImage,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(80),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 50,
                      child: InkWell(
                        onTap: pickBannerImage,
                        child: Icon(Icons.flip_camera_ios_outlined, size: 30),
                      ),
                    ),
                    // if (!isCollapsed)
                    Positioned(
                      bottom: 0,
                      left: 16,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: pickProfileImage,

                        child: profileImage == null
                            ? Stack(
                                children: [
                                  AppCachedNetworkImage(
                                    imageUrl: widget.user.profilePicture == null
                                        ? AppAssets.profileNetwork
                                        : widget.user.profilePicture!
                                              .startsWith('http')
                                        ? widget.user.profilePicture!
                                        : '${SupabaseConstants.storagePath}${widget.user.profilePicture}',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    isRounded: true,
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(80),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    left: 0,
                                    bottom: 0,
                                    child: Icon(
                                      Icons.flip_camera_ios_outlined,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(profileImage!),
                                radius: 50,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              16.heightBox,
              Text("Name", style: Theme.of(context).textTheme.titleMedium),
              4.heightBox,
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Name"),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              16.heightBox,
              Text("Bio", style: Theme.of(context).textTheme.titleMedium),
              4.heightBox,

              TextField(
                controller: bioController,
                decoration: InputDecoration(hintText: "Bio"),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
