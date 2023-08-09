import 'package:flutter/material.dart';

ThemeData DarkTheme(BuildContext context) {
  // final primary = Colors.blue[700]!;
  final primary = Colors.orange[400]!;

  final primaryColorDark = Colors.red[900]!;
  final secondaryColor = Colors.orangeAccent[100]!;
  final surfaceColor = Colors.grey[900]!;

  return ThemeData(
    primaryColor: primary,
    primaryColorDark: primaryColorDark,
    
    colorScheme: ColorScheme.dark(
        background: Colors.black,
        onPrimary: Colors.white,
        primary: primary,
        secondary: secondaryColor,
        surface: surfaceColor,
        onSurface: Colors.white
        // onBackground: Colors.white
        ),
    brightness: Brightness.dark,

    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.pink,
        refreshBackgroundColor: Colors.purple[800],
        circularTrackColor: Colors.blue),

    inputDecorationTheme: InputDecorationTheme(
      iconColor: Colors.white,
      suffixIconColor: Colors.white,
      focusColor: Colors.red,
      hintStyle: TextStyle(color: Colors.grey[100]!, fontSize: 20),
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.red, // Imposta il colore del cursore
    ),
  );
}

ThemeData ThemeLight(BuildContext context) {
  final primary = Colors.orange[300]!;
  dynamic background = Colors.grey[200];

  return ThemeData(
    primaryColor: primary,
    primaryColorDark: primary,
    colorScheme: ColorScheme.light(
      secondary: Colors.red,
      primary: primary,
      onPrimary: Colors.white,
      background: background,
      onBackground: Colors.green,
      onSurface: Colors.black,
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.pink,
      refreshBackgroundColor: primary,
      circularTrackColor: Colors.blue,
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.red, // Imposta il colore del cursore
    ),

    inputDecorationTheme: InputDecorationTheme(
      iconColor: Colors.white,
      suffixIconColor: Colors.white,
      hintStyle: TextStyle(color: Colors.grey[100]!, fontSize: 20),
    ),
  );
}
