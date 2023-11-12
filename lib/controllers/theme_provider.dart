import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final String key = 'theme_key';
  SharedPreferences? prefs;
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  void changeTheme() {
    _darkTheme = true;
    loadFromPrefs();
  }

  void loadFromPrefs() async {
    await initPrefs();
    _darkTheme = prefs!.getBool(key) ?? true;
    notifyListeners();
  }

  initPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  toggleTheme() {
    _darkTheme = !darkTheme;
    saveToPref();
    notifyListeners();
  }

  saveToPref() async {
    await initPrefs();
    prefs!.setBool(key, darkTheme);
  }
}
