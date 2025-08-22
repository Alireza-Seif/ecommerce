import 'package:flutter/material.dart';

extension StringToColor on String? {
  Color toColor() {
    String colorString = 'ff$this';
    int hexColor = int.parse(colorString, radix: 16);
    return Color(hexColor);
  }
}
