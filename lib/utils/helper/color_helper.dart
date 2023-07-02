import 'package:flutter/material.dart';

class ColorHelper {
  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    int colorValue = int.parse(hexColor, radix: 16);
    return Color(colorValue);
  }

  static Color getColorFromString(String stringColor) {

      stringColor = stringColor.replaceAll('Color(0xff', '').replaceAll(')', '');
    if (stringColor.length == 6) {
      stringColor = 'FF$stringColor';
    }

      int colorValue = int.parse(stringColor, radix: 16);

      Color color = Color(colorValue);

      return color;
    
  }
}
