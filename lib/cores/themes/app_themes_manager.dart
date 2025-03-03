import 'package:flutter/material.dart';
import 'color_pallete.dart';

abstract class AppThemesManager{
  static ThemeData lightTheme = ThemeData(
    drawerTheme:  DrawerThemeData(backgroundColor: Colors.black),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true
      ),
  );
  static ThemeData darkTheme = ThemeData(
      drawerTheme:  DrawerThemeData(backgroundColor: Colors.white),
      scaffoldBackgroundColor: Color(0xff171717),
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white
      ),
  );
}