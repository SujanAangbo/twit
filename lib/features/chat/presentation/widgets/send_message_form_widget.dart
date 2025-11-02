import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:twit/utils/ui/sized_box.dart';

import '../../../../core/common/image_picker_utils.dart';
import '../../../../theme/color_palette.dart';
import '../../data/models/room_model.dart';
import '../providers/message_provider.dart';

class SendMessageFormWidget extends ConsumerWidget {
  SendMessageFormWidget({super.key, required this.room});

  final RoomModel room;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageImageProvider = ref.watch(messageFileProvider);
    final state = ref.watch(messageProvider(room.id));
    final provider = ref.watch(messageProvider(room.id).notifier);
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
          if (messageImageProvider != null) ...[
            Container(
              margin: EdgeInsets.all(12),
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
                      messageImageProvider,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  12.widthBox,
                  Expanded(
                    child: Text(
                      path.basename(messageImageProvider.path),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 20),
                    onPressed: () {
                      ref.read(messageFileProvider.notifier).state = null;
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
                      final messageImage = await ImagePickerUtil.pickImage(
                        ImageSource.gallery,
                      );
                      ref.read(messageFileProvider.notifier).state =
                          messageImage;
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
                      controller: messageController,
                      minLines: 1,
                      maxLines: 4,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
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
                    icon: state.value?.isLoading ?? false
                        ? CircularProgressIndicator(
                            strokeWidth: 2,
                            padding: EdgeInsets.zero,
                          )
                        : Icon(Icons.send_rounded, color: Colors.white),
                    onPressed: () async {
                      if (messageController.text.trim().isNotEmpty ||
                          ref.read(messageFileProvider) != null) {
                        final file = ref.read(messageFileProvider);
                        await provider.sendMessage(
                          message: messageController.text.trim(),
                          messageImage: file,
                        );
                        messageController.clear();
                        ref.read(messageFileProvider.notifier).state = null;
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
