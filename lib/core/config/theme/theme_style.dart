import 'package:flutter/material.dart';
import 'package:kasir_app/core/config/theme/color_style.dart';

class ThemeStyle {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    canvasColor: ColorStyle.shadeBlue,
    scaffoldBackgroundColor: ColorStyle.white,
    cardColor: ColorStyle.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorStyle.primaryBlue,
      primary: ColorStyle.primaryBlue,
      onPrimary: Colors.white,
      error: ColorStyle.warningRed,
      onError: Colors.white,
      surfaceTint: Colors.white,
      surface: Colors.white,
      onSurface: ColorStyle.grey,
      brightness: Brightness.light,
    ),
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //   foregroundColor: ColorStyle.white,
    //   backgroundColor: ColorStyle.indigoPurple
    // ),
  );
}
