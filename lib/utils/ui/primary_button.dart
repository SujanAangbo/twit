import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.isLoading = false,
    this.height,
    this.width,
  });

  final String text;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorPalette.primaryColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: borderColor ?? ColorPalette.primaryColor,
            width: 1,
          ),
        ),
        child: isLoading
            ? CupertinoActivityIndicator()
            : Text(
                text,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: foregroundColor),
              ),
      ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.isLoading = false,
    this.height,
  });

  final String text;
  final double? height;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorPalette.primaryColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: borderColor ?? ColorPalette.primaryColor,
            width: 1,
          ),
        ),
        child: isLoading
            ? CupertinoActivityIndicator()
            : Text(
                text,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
      ),
    );
  }
}
