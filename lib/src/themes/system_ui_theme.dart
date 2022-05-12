import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUiTheme {
  SystemUiTheme._();

  static void setSystemChrome(ThemeMode themeMode) {
    // Setting screen orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Setting status bar and navigation bar themes
    final Brightness brightness;

    if (themeMode == ThemeMode.light) {
      brightness = Brightness.light;
    } else if (themeMode == ThemeMode.dark) {
      brightness = Brightness.dark;
    } else {
      brightness = WidgetsBinding.instance?.window.platformBrightness ??
          Brightness.light;
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            brightness == Brightness.light ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: brightness == Brightness.light
            ? const Color(0xFFF3F3F3)
            : const Color(0xFF181818),
        systemNavigationBarIconBrightness:
            brightness == Brightness.light ? Brightness.dark : Brightness.light,
      ),
    );
  }
}
