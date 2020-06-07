import 'package:flutter/material.dart';

class BotiAppTheme {
  Color primary = Color(0xFF007e78);
  Color primaryLight = Color(0xFF4baea7);
  Color primaryDark = Color(0xFF00514c);

  Color secondaryOverlay = Color(0x5008b89d);
  Color secondary = Color(0xFF08b89d);
  Color secondaryLight = Color(0xFF5debce);
  Color secondaryDark = Color(0xFFa5407d);

  BotiAppTheme();

  ThemeData get themeData {
    TextTheme txtTheme = ThemeData.light().textTheme;
    Color txtColor = txtTheme.bodyText1.color;
    ColorScheme colorScheme = ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        primaryVariant: primaryDark,
        secondary: secondary,
        secondaryVariant: secondaryDark,
        background: Colors.white,
        surface: Colors.white,
        onBackground: txtColor,
        onSurface: txtColor,
        onError: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        error: Colors.red.shade400);

    var theme =
        ThemeData.from(textTheme: txtTheme, colorScheme: colorScheme).copyWith(
      buttonColor: primary,
      cursorColor: secondary,
      highlightColor: secondaryOverlay,
      toggleableActiveColor: secondary,
      accentColor: secondary,
    );
    return theme;
  }
}
