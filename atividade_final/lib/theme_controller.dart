import 'package:flutter/material.dart';
import 'themes/light_theme.dart';
import 'themes/dark_theme.dart';

//CONTROLADOR DE TEMAS
class ThemeController {
  late final ValueNotifier<ThemeData> themeNotifier;

  ThemeController() {
    // Define o tema com base no horário
    final hour = DateTime.now().hour;
    final isDayTime = hour >= 6 && hour < 18;
    final initialTheme = isDayTime ? lightTheme : darkTheme;

    themeNotifier = ValueNotifier<ThemeData>(initialTheme);
  }

  void toggleTheme() {
    themeNotifier.value =
        themeNotifier.value.brightness == Brightness.dark ? lightTheme : darkTheme;
  }

  ThemeData get currentTheme => themeNotifier.value;
}