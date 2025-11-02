import 'package:flutter/material.dart';
import 'package:twit/utils/ui/sized_box.dart';

import '../../../../core/common/date_formatter.dart';
import '../../../../core/constants/supabase_constants.dart';
import '../../../../theme/color_palette.dart';
import '../../../../utils/ui/image_overlay.dart';
import '../../data/models/message_model.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.message, required this.isMe});

  final MessageModel message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            margin: EdgeInsets.only(
              bottom: 8,
              left: isMe ? 48 : 0,
              right: isMe ? 0 : 48,
            ),
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Image with text message
                if (message.image != null)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(18),
                        topLeft: Radius.circular(18),
                        bottomLeft: message.message.isEmpty
                            ? (isMe ? Radius.circular(18) : Radius.circular(4))
                            : Radius.zero,
                        bottomRight: message.message.isEmpty
                            ? (isMe ? Radius.circular(4) : Radius.circular(18))
                            : Radius.zero,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isMe
                              ? ColorPalette.blueColor.withOpacity(0.2)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                            bottomLeft: message.message.isEmpty
                                ? (isMe
                                      ? Radius.circular(18)
                                      : Radius.circular(0))
                                : Radius.zero,
                            bottomRight: message.message.isEmpty
                                ? (isMe
                                      ? Radius.circular(4)
                                      : Radius.circular(18))
                                : Radius.zero,
                          ),
                          child: Stack(
                            children: [
                              ImageOverlay(
                                width: MediaQuery.of(context).size.width * 0.65,
                                height: 250,
                                fit: BoxFit.cover,
                                imageUrl:
                                    '${SupabaseConstants.storagePath}/${message.image}',
                              ),
                              // Timestamp overlay on image (only if no text)
                              if (message.message.isEmpty)
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          DateFormatter.formatTime(
                                            DateTime.parse(
                                              message.createdAt,
                                            ).toLocal(),
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        if (isMe) ...[
                                          4.widthBox,
                                          Icon(
                                            Icons.done_all,
                                            size: 14,
                                            color: message.isSeen
                                                ? ColorPalette.blueColor
                                                : Colors.white70,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // Text below image (if exists)
                        if (message.message.isNotEmpty)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              gradient: isMe
                                  ? LinearGradient(
                                      colors: [
                                        ColorPalette.blueColor,
                                        ColorPalette.blueColor.withOpacity(0.8),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              borderRadius: BorderRadius.only(
                                bottomLeft: isMe
                                    ? Radius.circular(18)
                                    : Radius.circular(4),
                                bottomRight: isMe
                                    ? Radius.circular(4)
                                    : Radius.circular(18),
                              ),
                            ),
                            child: Text(
                              message.message,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: isMe
                                        ? Colors.white
                                        : ColorPalette.black,
                                    height: 1.4,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  )
                // Text-only message
                else if (message.message.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: isMe
                          ? LinearGradient(
                              colors: [
                                ColorPalette.blueColor,
                                ColorPalette.blueColor.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: isMe ? null : Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(18),
                        topLeft: Radius.circular(18),
                        bottomLeft: isMe
                            ? Radius.circular(18)
                            : Radius.circular(4),
                        bottomRight: isMe
                            ? Radius.circular(4)
                            : Radius.circular(18),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isMe
                              ? ColorPalette.blueColor.withOpacity(0.2)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message.message,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isMe ? Colors.white : ColorPalette.black,
                        height: 1.4,
                      ),
                    ),
                  ),
                // Timestamp (only for text messages or image with text)
                if (message.message.isNotEmpty) ...[
                  4.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormatter.formatTime(
                            DateTime.parse(message.createdAt).toLocal(),
                          ),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: ColorPalette.greyColor.withOpacity(0.7),
                                fontSize: 11,
                              ),
                        ),
                        if (isMe) ...[
                          4.widthBox,
                          Icon(
                            Icons.done_all,
                            size: 14,
                            color: message.isSeen
                                ? ColorPalette.blueColor
                                : ColorPalette.greyColor.withOpacity(0.5),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
