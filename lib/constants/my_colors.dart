// Define a map of custom dark green color swatches
import 'package:flutter/material.dart';

Map<int, Color> customDarkGreenSwatch = {
  50: const Color.fromRGBO(16, 82, 19, .1),
  100: const Color.fromRGBO(16, 82, 19, .2),
  200: const Color.fromRGBO(16, 82, 19, .3),
  300: const Color.fromRGBO(16, 82, 19, .4),
  400: const Color.fromRGBO(16, 82, 19, .5),
  500: const Color.fromRGBO(16, 82, 19, .6),
  600: const Color.fromRGBO(16, 82, 19, .7),
  700: const Color.fromRGBO(16, 82, 19, .8),
  800: const Color.fromRGBO(16, 82, 19, .9),
  900: const Color.fromRGBO(16, 82, 19, 1),
};

MaterialColor customDarkGreen =
    MaterialColor(0xFF105213, customDarkGreenSwatch);

const MaterialColor customLightGreen = MaterialColor(
  0xFFD6FFD7,
  <int, Color>{
    50: Color(0xFFF0FFF1),
    100: Color(0xFFE6FFE7),
    200: Color(0xFFCEFFCE),
    300: Color(0xFFB5FFB6),
    400: Color(0xFF9DFF9D),
    500: Color(0xFFD6FFD7),
    600: Color(0xFF7AFF7B),
    700: Color(0xFF5FFF5F),
    800: Color(0xFF46FF46),
    900: Color(0xFF2CFF2C),
  },
);
