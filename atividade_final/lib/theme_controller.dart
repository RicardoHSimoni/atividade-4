import 'package:flutter/material.dart';
import 'themes/light_theme.dart';
import 'themes/dark_theme.dart';

class ThemeController {
  final ValueNotifier<ThemeData> themeNotifier = ValueNotifier<ThemeData>(lightTheme);

  void toggleTheme() {
    themeNotifier.value =
        themeNotifier.value.brightness == Brightness.dark ? lightTheme : darkTheme;
  }

  ThemeData get currentTheme => themeNotifier.value;
}
