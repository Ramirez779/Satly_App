// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _key = 'sparkseed_theme_mode';

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadFromPrefs();
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    _saveToPrefs(mode);
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString(_key) ?? 'light';
      switch (value) {
        case 'dark':
          _themeMode = ThemeMode.dark;
          break;
        case 'system':
          _themeMode = ThemeMode.system;
          break;
        case 'light':
        default:
          _themeMode = ThemeMode.light;
      }
      notifyListeners(); // notifica cuando termina de cargar
    } catch (_) {
      // si falla, permanecerá en ThemeMode.light
    }
  }

  Future<void> _saveToPrefs(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    final str = mode == ThemeMode.dark
        ? 'dark'
        : mode == ThemeMode.system
        ? 'system'
        : 'light';
    await prefs.setString(_key, str);
  }
}
