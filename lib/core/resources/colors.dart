import 'package:flutter/material.dart';

class MyColors {
  MyColors._();

  /// reference: https://www.themoviedb.org/about/logos-attribution

  static const primary = MaterialColor(
    0xFF0D253F,
    <int, Color>{
      50: Color(0xFFE2E5E8),
      100: Color(0xFFB6BEC5),
      200: Color(0xFF86929F),
      300: Color(0xFF566679),
      400: Color(0xFF31465C),
      500: Color(0xFF0D253F),
      600: Color(0xFF0B2139),
      700: Color(0xFF091B31),
      800: Color(0xFF071629),
      900: Color(0xFF030D1B),
    },
  );

  static const secondary = MaterialColor(
    0xFF01B4E4,
    <int, Color>{
      50: Color(0xFFE1F6FC),
      100: Color(0xFFB3E9F7),
      200: Color(0xFF80DAF2),
      300: Color(0xFF4DCBEC),
      400: Color(0xFF27BFE8),
      500: Color(0xFF01B4E4),
      600: Color(0xFF01ADE1),
      700: Color(0xFF01A4DD),
      800: Color(0xFF019CD9),
      900: Color(0xFF008CD1),
    },
  );

  static const tertiary = MaterialColor(
    0xFF90CEA1,
    <int, Color>{
      50: Color(0xFFF2F9F4),
      100: Color(0xFFDEF0E3),
      200: Color(0xFFC8E7D0),
      300: Color(0xFFB1DDBD),
      400: Color(0xFFA1D5AF),
      500: Color(0xFF90CEA1),
      600: Color(0xFF88C999),
      700: Color(0xFF7DC28F),
      800: Color(0xFF73BC85),
      900: Color(0xFF61B074),
    },
  );

  static const error = MaterialColor(
    0xFFEB4755,
    {
      50: Color(0xFFFDE9EB),
      100: Color(0xFFF9C8CC),
      200: Color(0xFFF5A3AA),
      300: Color(0xFFF17E88),
      400: Color(0xFFEE636F),
      500: Color(0xFFEB4755),
      600: Color(0xFFE9404E),
      700: Color(0xFFE53744),
      800: Color(0xFFE22F3B),
      900: Color(0xFFDD202A),
    },
  );

  static const grey = MaterialColor(
    0xFF9E9E9E,
    {
      50: Color(0xFFFAFAFA),
      100: Color(0xFFF5F5F5),
      200: Color(0xFFEEEEEE),
      300: Color(0xFFE0E0E0),
      350: Color(0xFFD6D6D6),
      400: Color(0xFFBDBDBD),
      500: Color(0xFF9E9E9E),
      600: Color(0xFF757575),
      700: Color(0xFF616161),
      800: Color(0xFF424242),
      850: Color(0xFF303030),
      900: Color(0xFF212121),
    },
  );

  static const white = Colors.white;
  static const black = Colors.black;
}
