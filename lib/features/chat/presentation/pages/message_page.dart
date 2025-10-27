import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/app/routes/app_route.gr.dart';
import 'package:twit/core/constants/app_assets.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';
import 'package:twit/features/chat/data/models/room_model.dart';
import 'package:twit/features/chat/presentation/providers/chat_provider.dart';
import 'package:twit/features/chat/presentation/widgets/send_message_form_widget.dart';
import 'package:twit/theme/color_palette.dart';
import 'package:twit/utils/ui/app_cached_network_image.dart';
import 'package:twit/utils/ui/focus_scaffold.dart';
import 'package:twit/utils/ui/sized_box.dart';

import '../../../../core/constants/supabase_constants.dart';
import '../../../../utils/ui/default_app_bar.dart';
import '../widgets/message_card.dart';

@RoutePage()
class MessagePage extends ConsumerStatefulWidget {
  MessagePage({super.key, required this.room});

  final RoomModel room;

  @override
  ConsumerState<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends ConsumerState<MessagePage> {
  bool isInitial = true;

  @override
  void initState() {
    super.initState();
    if (widget.room.lastSender != ref.read(userProvider)!.id) {
      ref.read(chatProvider.notifier).markAllMyMessageAsRead(widget.room.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomMessageState = ref.watch(messageProvider(widget.room.id));
    final currentUser = ref.watch(userProvider)!;
    final friendUser = (widget.room.members.toList())..remove(currentUser.id);

    return SafeArea(
      child: FocusScaffold(
        backgroundColor: ColorPalette.greyColor.withOpacity(0.05),
        appBar: DefaultAppBar(
          centerTitle: false,
          titleWidget: ref
              .watch(
                userDetailProvider(friendUser.firstOrNull ?? currentUser.id),
              )
              .when(
                data: (user) {
                  return InkWell(
                    onTap: () {
                      if (user != null) {
                        context.router.push(ProfileRoute(user: user));
                      }
                    },
                    child: Row(
                      children: [
                        Hero(
                          tag: 'profile_${user?.id}',
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorPalette.blueColor.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: AppCachedNetworkImage(
                              imageUrl: user?.profilePicture == null
                                  ? AppAssets.profileNetwork
                                  : '${SupabaseConstants.storagePath}/${user!.profilePicture}',
                              height: 42,
                              width: 42,
                              isRounded: true,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        12.widthBox,
                        Text(
                          user?.fullName ?? "Unknown",
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  );
                },
                error: (err, st) {
                  return Row(
                    children: [
                      AppCachedNetworkImage(imageUrl: AppAssets.profileNetwork),
                      8.widthBox,
                      Text(
                        "Unknown",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  );
                },
                loading: () {
                  return CircularProgressIndicator();
                },
              ),
        ),
        body: Column(
          children: [
            Expanded(
              child: roomMessageState.when(
                data: (messages) {
                  if (messages.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: ColorPalette.greyColor.withOpacity(0.3),
                          ),
                          16.heightBox,
                          Text(
                            "No messages yet",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: ColorPalette.greyColor),
                          ),
                          8.heightBox,
                          Text(
                            "Start the conversation!",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: ColorPalette.greyColor.withOpacity(
                                    0.7,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: messages.length,
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.senderId == currentUser.id;

                      return MessageCard(message: message, isMe: isMe);
                    },
                  );
                },
                error: (err, st) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red.withOpacity(0.5),
                        ),
                        16.heightBox,
                        Text(
                          "Something went wrong",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        8.heightBox,
                        Text(
                          err.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
                loading: () {
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            // Message input section
            SendMessageFormWidget(room: widget.room),
          ],
        ),
      ),
    );
  }
}
