import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    primaryColor: Colors.deepPurple
    // Define other light theme properties such as colors, fonts, etc.
    );

final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    primaryColor: Colors.deepPurple
    // Define other dark theme properties such as colors, fonts, etc.
    );
