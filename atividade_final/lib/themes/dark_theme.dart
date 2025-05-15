import 'package:flutter/material.dart';

// dark_theme.dart
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.indigo,
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
  ),
  // Adicione outros estilos conforme necessário para o tema escuro
);