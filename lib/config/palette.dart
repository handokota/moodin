import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor Dark = MaterialColor(
    0xFF002B5B, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF002B5B),
      100: Color(0xFF002B5B),
      200: Color(0xFF002B5B),
      300: Color(0xFF002B5B),
      400: Color(0xFF002B5B),
      500: Color(0xFF002B5B),
      600: Color(0xFF002B5B),
      700: Color(0xFF002B5B),
      800: Color(0xFF002B5B),
      900: Color(0xFF002B5B),
    },
  );
}