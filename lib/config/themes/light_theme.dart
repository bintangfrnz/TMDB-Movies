import 'package:flutter/material.dart';
import 'package:tmdb_movies/core/resources/colors.dart';

class MyLightTheme {
  MyLightTheme._();

  static const fontFamily = 'SF Pro';

  static ColorScheme get colorScheme => ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: MyColors.primary,
        error: MyColors.error,
      );

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        fontFamily: fontFamily,
        colorScheme: colorScheme,
        primaryColor: MyColors.primary,
      );
}
