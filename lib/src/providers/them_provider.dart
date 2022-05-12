import 'package:flutter/material.dart';
import 'package:morse_pad/src/themes/custom_theme_data.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? _themeData;

  ThemeProvider(ThemeMode themeMode) {
    setTheme(themeMode);
  }

  ThemeData getTheme() {
    return _themeData!;
  }

  void setTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        _themeData = CustomThemeData.light();
        break;
      case ThemeMode.dark:
        _themeData = CustomThemeData.dark();
        break;
      default:
        _themeData = WidgetsBinding.instance?.window.platformBrightness ==
                Brightness.dark
            ? CustomThemeData.dark()
            : CustomThemeData.light();
    }

    notifyListeners();
  }
}
