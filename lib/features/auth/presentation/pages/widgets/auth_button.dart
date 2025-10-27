import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/color_palette.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isLoading = false,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isLoading ? () {} : onPressed ?? () {},
      child: isLoading
          ? CupertinoActivityIndicator(color: ColorPalette.primaryColor)
          : Text(title),
      color: ColorPalette.whiteColor,
      textColor: ColorPalette.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
