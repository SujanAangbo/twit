import 'package:flutter/material.dart';
import 'package:twit/theme/color_palette.dart';

class AppTheme {
  static OutlineInputBorder border(final Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color),
  );

  static ThemeData theme(BuildContext context) => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorPalette.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorPalette.backgroundColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorPalette.blueColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: border(ColorPalette.greyColor),
      disabledBorder: border(ColorPalette.greyColor),
      focusedBorder: border(ColorPalette.primaryColor),
      errorBorder: border(ColorPalette.redColor),
      focusedErrorBorder: border(ColorPalette.primaryColor),
      hintStyle: Theme.of(
        context,
      ).textTheme.bodyLarge!.copyWith(color: ColorPalette.greyColor),
    ),
  );
}
