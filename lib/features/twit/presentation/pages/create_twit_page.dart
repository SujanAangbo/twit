import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/core/common/form_validation.dart';
import 'package:twit/core/constants/constants.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/twit/presentation/providers/create_twit_provider.dart';
import 'package:twit/theme/color_palette.dart';
import 'package:twit/utils/ui/app_cached_network_image.dart';
import 'package:twit/utils/ui/app_horizontal_divider.dart';
import 'package:twit/utils/ui/default_app_bar.dart';
import 'package:twit/utils/ui/focus_scaffold.dart';
import 'package:twit/utils/ui/primary_button.dart';
import 'package:twit/utils/ui/sized_box.dart';

@RoutePage()
class CreateTwitPage extends ConsumerStatefulWidget {
  const CreateTwitPage({super.key});

  @override
  ConsumerState<CreateTwitPage> createState() => _CreateTwitPageState();
}

class _CreateTwitPageState extends ConsumerState<CreateTwitPage> {
  final TextEditingController _contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createTwitProvider);
    final provider = ref.watch(createTwitProvider.notifier);
    final userState = ref.watch(userProvider);

    return FocusScaffold(
      appBar: DefaultAppBar(
        leading: InkWell(
          onTap: () => context.maybePop(),
          child: const Icon(Icons.close, size: 28),
        ),
        action: AppTextButton(
          backgroundColor: ColorPalette.primaryColor,
          text: 'Tweet',
          isLoading: state.isLoading,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await provider.createTwit(
                _contentController.text.trim(),
                context,
              );
              _contentController.clear();
              if (state.images.isNotEmpty) {
                provider.removeImage(0);
              }
            }
          },
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildUserAvatar(userState),
                    8.widthBox,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TextFormField(
                            validator: (value) => FormValidation.emptyValidator(
                              value?.trim(),
                              'Content',
                            ),
                            controller: _contentController,
                            decoration: InputDecoration(
                              hintText: 'What\'s Happening',
                              hintStyle: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: ColorPalette.greyColor),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: null,
                          ),
                          16.heightBox,
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(state.images.length, (
                                  index,
                                ) {
                                  return Container(
                                    height: 400,
                                    margin: EdgeInsetsGeometry.symmetric(
                                      vertical: 4,
                                    ),
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        Image.file(
                                          state.images[index],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                        Positioned(
                                          right: 10,
                                          top: 10,
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              shape: BoxShape.circle,
                                            ),
                                            child: AppIconButton(
                                              onPressed: () {
                                                provider.removeImage(index);
                                              },
                                              icon: Icons.close,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const AppHorizontalDivider(),
              _buildMediaButton(provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar(dynamic userState) {
    final String profileImageUrl = userState?.profilePicture == null
        ? AppAssets.profileNetwork
        : "${SupabaseConstants.storagePath}/${userState?.profilePicture}";

    return AppCachedNetworkImage(
      imageUrl: profileImageUrl,
      height: 40,
      width: 40,
      isRounded: true,
      fit: BoxFit.cover,
    );
  }

  Widget _buildMediaButton(CreateTwitProvider provider) {
    return IconButton(
      onPressed: () => provider.pickTwitImages(isMultiple: false),
      icon: const Icon(Icons.image_outlined),
      iconSize: 32,
    );
  }
}

// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:twit/core/common/form_validation.dart';
// import 'package:twit/core/constants/constants.dart';
// import 'package:twit/features/auth/presentation/providers/user_provider.dart';
// import 'package:twit/features/twit/presentation/providers/create_twit_provider.dart';
// import 'package:twit/theme/color_palette.dart';
// import 'package:twit/utils/ui/app_horizontal_divider.dart';
// import 'package:twit/utils/ui/focus_scaffold.dart';
// import 'package:twit/utils/ui/sized_box.dart';
//
// import '../../../../utils/ui/default_app_bar.dart';
// import '../../../../utils/ui/primary_button.dart';
//
// @RoutePage()
// class CreateTwitPage extends ConsumerStatefulWidget {
//   const CreateTwitPage({super.key});
//
//   @override
//   ConsumerState<CreateTwitPage> createState() => _CreateTwitPageState();
// }
//
// class _CreateTwitPageState extends ConsumerState<CreateTwitPage> {
//   TextEditingController contentController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(createTwitProvider);
//     final provider = ref.watch(createTwitProvider.notifier);
//     final userState = ref.watch(userProvider);
//
//     return FocusScaffold(
//       appBar: DefaultAppBar(
//         leading: InkWell(
//           onTap: () {
//             context.maybePop();
//           },
//           child: Icon(Icons.close),
//         ),
//         action: PrimaryButton(
//           text: 'Tweet',
//           isLoading: state.isLoading,
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               provider.createTwit(contentController.text.trim(), context);
//             }
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(
//                         userState?.profilePicture == null
//                             ? AppAssets.profileNetwork
//                             : "${SupabaseConstants.storagePath}/${userState?.profilePicture}",
//                       ),
//                     ),
//                     8.widthBox,
//                     Expanded(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Expanded(
//                             child: TextFormField(
//                               validator: (value) {
//                                 return FormValidation.emptyValidator(
//                                   value?.trim(),
//                                   'Content',
//                                 );
//                               },
//                               controller: contentController,
//                               decoration: InputDecoration(
//                                 hintText: 'What\'s Happening',
//                                 hintStyle: Theme.of(context)
//                                     .textTheme
//                                     .titleLarge!
//                                     .copyWith(color: ColorPalette.greyColor),
//                                 border: InputBorder.none,
//                                 enabledBorder: InputBorder.none,
//                                 focusedBorder: InputBorder.none,
//                                 disabledBorder: InputBorder.none,
//                                 errorBorder: InputBorder.none,
//                                 focusedErrorBorder: InputBorder.none,
//                               ),
//                               style: Theme.of(context).textTheme.titleLarge,
//                               maxLines: null,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               AppHorizontalDivider(),
//               IconButton(
//                 onPressed: () {
//                   provider.pickTwitImages();
//                 },
//                 icon: Icon(Icons.image_outlined),
//                 iconSize: 32,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
