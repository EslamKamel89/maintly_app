// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Clr {
  // Core Colors
  Color primaryColor;
  Color primaryColorLight;
  Color primaryColorDark;
  Color secondaryHeaderColor;
  Color scaffoldBackgroundColor;
  Color dialogBackgroundColor;
  Color cardColor;
  Color canvasColor;
  Clr({
    required this.primaryColor,
    required this.primaryColorLight,
    required this.primaryColorDark,
    required this.secondaryHeaderColor,
    required this.scaffoldBackgroundColor,
    required this.dialogBackgroundColor,
    required this.cardColor,
    required this.canvasColor,
  });
}

final lightClr = Clr(
  primaryColor: const Color(0xFF4397CB),
  primaryColorLight: const Color(0xFF6DB5DE),
  primaryColorDark: const Color(0xFF2F7CAD),

  secondaryHeaderColor: const Color(0xFFF3F8FC),

  scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Slate 50
  dialogBackgroundColor: const Color(0xFFFFFFFF),
  cardColor: const Color(0xFFFFFFFF),
  canvasColor: const Color(0xFFF8FAFC),
);

final darkClr = Clr(
  primaryColor: const Color(0xFF4397CB),
  primaryColorLight: const Color(0xFF6DB5DE),
  primaryColorDark: const Color(0xFF2F7CAD),

  secondaryHeaderColor: const Color(0xFF1E293B), // Slate 800

  scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate 900
  dialogBackgroundColor: const Color(0xFF1E293B), // Slate 800
  cardColor: const Color(0xFF1E293B),
  canvasColor: const Color(0xFF0F172A),
);

final ThemeData lightTheme = ThemeData(
  // Core Colors
  primaryColor: lightClr.primaryColor,
  primaryColorLight: lightClr.primaryColorLight,
  primaryColorDark: lightClr.primaryColorDark,
  secondaryHeaderColor: lightClr.secondaryHeaderColor,
  scaffoldBackgroundColor: lightClr.scaffoldBackgroundColor,
  cardColor: lightClr.cardColor,
  canvasColor: lightClr.scaffoldBackgroundColor,

  // Buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightClr.primaryColor, // Button background color
      foregroundColor: Colors.white, // Button text color
      shadowColor: lightClr.primaryColorDark, // Button shadow color
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: lightClr.primaryColor, // Button text color
      side: BorderSide(color: lightClr.primaryColor), // Border color
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: lightClr.primaryColor, // Text color
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: lightClr.primaryColor,
    foregroundColor: Colors.white, // Text and icon color
    elevation: 4,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

  // FloatingActionButton
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: lightClr.primaryColor, // Primary color
    foregroundColor: Colors.white, // Icon color
  ),

  // Input Fields
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: lightClr.primaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: lightClr.primaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: lightClr.primaryColorDark),
    ),
    labelStyle: TextStyle(color: Colors.black54, fontSize: 16),
    hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
  ),

  // Divider
  dividerColor: const Color(0xFFE2E8F0), // Light
  // Icons
  iconTheme: IconThemeData(
    color: lightClr.primaryColor, // Primary color for icons
  ),
  primaryIconTheme: IconThemeData(
    color: Colors.white, // White icons for primary elements
  ),

  // SnackBar
  snackBarTheme: SnackBarThemeData(
    backgroundColor: lightClr.primaryColor,
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
  ),

  // bottom navigatio bar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: lightClr.primaryColor, // Highlight color
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
  ),
  dialogTheme: DialogThemeData(backgroundColor: lightClr.dialogBackgroundColor),
  colorScheme: ColorScheme.fromSeed(
    seedColor: lightClr.primaryColor,
    brightness: Brightness.light,
  ),
);

final ThemeData darkTheme = ThemeData(
  // Core Colors
  brightness: Brightness.dark,
  primaryColor: darkClr.primaryColor,
  primaryColorDark: darkClr.primaryColorDark,
  primaryColorLight: darkClr.primaryColorLight,
  scaffoldBackgroundColor: darkClr.scaffoldBackgroundColor,
  cardColor: darkClr.cardColor,
  secondaryHeaderColor: darkClr.secondaryHeaderColor,
  canvasColor: darkClr.scaffoldBackgroundColor,

  // Buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkClr.primaryColor, // Button background color
      foregroundColor: Colors.white, // Button text color
      shadowColor: darkClr.primaryColorDark, // Button shadow color
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: darkClr.primaryColor, // Button text color
      side: BorderSide(color: darkClr.primaryColor), // Border color
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: darkClr.primaryColor, // Text color
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: darkClr.primaryColor,
    foregroundColor: Colors.white, // Text and icon color
    elevation: 4,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

  // FloatingActionButton
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkClr.primaryColor, // Primary color
    foregroundColor: Colors.white, // Icon color
  ),

  // Input Fields
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF334155),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: darkClr.primaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: darkClr.primaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: darkClr.primaryColorDark),
    ),
    labelStyle: TextStyle(color: Colors.white70, fontSize: 16),
    hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
  ),

  // Divider
  dividerColor: const Color(0xFF334155), // Dark
  // Icons
  iconTheme: IconThemeData(color: Colors.white70),
  primaryIconTheme: IconThemeData(
    color: Colors.white, // White icons for primary elements
  ),

  // SnackBar
  snackBarTheme: SnackBarThemeData(
    backgroundColor: darkClr.primaryColor,
    contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
  ),
  // bottom navigatio bar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: darkClr.primaryColor, // Highlight color
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
  ),
  dialogTheme: DialogThemeData(backgroundColor: darkClr.dialogBackgroundColor),
  colorScheme: ColorScheme.fromSeed(
    seedColor: darkClr.primaryColor,
    brightness: Brightness.dark,
  ),
);
