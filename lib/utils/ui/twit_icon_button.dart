import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twit/utils/ui/sized_box.dart';

import '../../theme/color_palette.dart';

class TwitIconButton extends StatelessWidget {
  final String iconPath;
  final String value;
  final VoidCallback? onPressed;

  const TwitIconButton({
    super.key,
    required this.iconPath,
    required this.value,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(
              ColorPalette.greyColor,
              BlendMode.srcIn,
            ),
            height: 24,
            width: 24,
          ),
          4.widthBox,
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
