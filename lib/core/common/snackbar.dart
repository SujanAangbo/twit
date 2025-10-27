import 'package:flutter/material.dart';
import 'package:twit/theme/color_palette.dart';

enum SnackBarStatus {
  success,
  error,
  warning,
  info;

  Color get getStatusColor {
    switch (this) {
      case SnackBarStatus.success:
        return ColorPalette.successColor;
      case SnackBarStatus.error:
        return ColorPalette.errorColor;
      case SnackBarStatus.warning:
        return ColorPalette.warningColor;
      case SnackBarStatus.info:
        return ColorPalette.infoColor;
    }
  }
}

void showSnackBar({
  required BuildContext context,
  required String message,
  SnackBarStatus status = SnackBarStatus.info,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: status.getStatusColor,
      content: Text(
        message,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: ColorPalette.whiteColor),
      ),
    ),
  );
}
