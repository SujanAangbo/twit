import 'package:flutter/material.dart';
import 'package:twit/utils/ui/sized_box.dart';

import '../../../../theme/color_palette.dart';

class FollowerCountWidget extends StatelessWidget {
  const FollowerCountWidget({
    super.key,
    required this.count,
    required this.text,
  });

  final int count;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${count}",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        4.widthBox,
        Text(
          text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorPalette.greyColor,
          ),
        ),
      ],
    );
  }
}
