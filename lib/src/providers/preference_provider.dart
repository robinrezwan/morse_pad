import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceProvider extends ChangeNotifier {
  static const String _themeMode = 'themeMode';

  static const Map<String, dynamic> _defaultPreferences = {
    _themeMode: ThemeMode.system,
  };

  final SharedPreferences _preferences;

  PreferenceProvider(this._preferences);

  ThemeMode getThemeMode() {
    final ThemeMode themeMode;

    switch (_preferences.getString(_themeMode)) {
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      case 'system':
        themeMode = ThemeMode.system;
        break;
      default:
        themeMode = _defaultPreferences[_themeMode];
    }

    return themeMode;
  }

  void setThemeMode(ThemeMode themeMode) {
    _preferences.setString(_themeMode, themeMode.name);

    notifyListeners();
  }
}
