import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:morse_pad/src/themes/system_ui_theme.dart';
import 'package:morse_pad/src/utilities/text_theme_extension.dart';

// Logger
final Logger log = Logger();

class CustomThemeData {
  CustomThemeData._();

  static const Color _primaryColor = Color(0xFF3F87FF);

  /// Light theme for this app
  static ThemeData light() {
    // Setting system chrome
    SystemUiTheme.setSystemChrome(ThemeMode.light);

    // Creating theme data
    final ThemeData baseThemeDataLight = ThemeData.light();

    const ColorScheme colorSchemeLight = ColorScheme(
      brightness: Brightness.light,
      primary: _primaryColor,
      onPrimary: Colors.white,
      secondary: _primaryColor,
      onSecondary: Colors.white,
      error: Color(0xFFB00020),
      onError: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Color(0xFFF8F8F8),
      onSurface: Colors.black,
      surfaceVariant: Colors.white,
      onSurfaceVariant: Colors.black,
    );

    const Color iconColor = Color(0xFF212121);

    return ThemeData(
      brightness: Brightness.light,
      colorScheme: colorSchemeLight,
      primaryColor: colorSchemeLight.primary,
      toggleableActiveColor: colorSchemeLight.primary,
      scaffoldBackgroundColor: colorSchemeLight.background,
      iconTheme: baseThemeDataLight.iconTheme.copyWith(color: iconColor),
      textTheme: _textTheme(baseThemeDataLight),
      appBarTheme: _appBarTheme(baseThemeDataLight, colorSchemeLight).copyWith(
        iconTheme: baseThemeDataLight.iconTheme.copyWith(color: iconColor),
      ),
      cardTheme: _cardTheme(baseThemeDataLight).copyWith(
        color: colorSchemeLight.surface,
      ),
      bottomSheetTheme: _bottomSheetTheme(baseThemeDataLight),
      elevatedButtonTheme: _elevatedButtonTheme(),
      splashFactory: _splashFactory(),
    );
  }

  /// Dark theme for this app
  static ThemeData dark() {
    // Setting system chrome
    SystemUiTheme.setSystemChrome(ThemeMode.dark);

    // Creating theme data
    final ThemeData baseThemeDataDark = ThemeData.dark();

    const ColorScheme colorSchemeDark = ColorScheme(
      brightness: Brightness.dark,
      primary: _primaryColor,
      onPrimary: Colors.white,
      secondary: _primaryColor,
      onSecondary: Colors.white,
      error: Color(0xFFB00020),
      onError: Colors.white,
      background: Color(0xFF222222),
      onBackground: Colors.white,
      surface: Color(0xFF2A2A2A),
      onSurface: Colors.white,
      surfaceVariant: Color(0xFF2A2A2A),
      onSurfaceVariant: Colors.white,
    );

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: colorSchemeDark,
      primaryColor: colorSchemeDark.primary,
      scaffoldBackgroundColor: colorSchemeDark.background,
      toggleableActiveColor: colorSchemeDark.primary,
      textTheme: _textTheme(baseThemeDataDark),
      appBarTheme: _appBarTheme(baseThemeDataDark, colorSchemeDark),
      cardTheme: _cardTheme(baseThemeDataDark).copyWith(
        color: colorSchemeDark.surface,
      ),
      bottomSheetTheme: _bottomSheetTheme(baseThemeDataDark).copyWith(
        backgroundColor: colorSchemeDark.surface,
      ),
      elevatedButtonTheme: _elevatedButtonTheme(),
      splashFactory: _splashFactory(),
    );
  }

  static TextTheme _textTheme(ThemeData baseThemeData) {
    return baseThemeData.textTheme.applyWith(
      fontFamily: 'Product Sans',
      fontFeatures: const [
        FontFeature.disable('calt'),
        FontFeature.disable('clig'),
      ],
    );
  }

  static AppBarTheme _appBarTheme(
      ThemeData baseThemeData, ColorScheme colorScheme) {
    return baseThemeData.appBarTheme.copyWith(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      color: colorScheme.surfaceVariant,
      titleTextStyle: TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 20,
        fontFeatures: const [
          FontFeature.disable('calt'),
          FontFeature.disable('clig'),
        ],
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  static CardTheme _cardTheme(ThemeData baseThemeData) {
    return baseThemeData.cardTheme.copyWith(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  static BottomSheetThemeData _bottomSheetTheme(ThemeData baseThemeData) {
    return baseThemeData.bottomSheetTheme.copyWith(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

  static InteractiveInkFeatureFactory _splashFactory() {
    return InkRipple.splashFactory;
  }
}
