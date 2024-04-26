import 'dart:ui';

Color stringToColor(String colorHex) {
  int parsedHex = int.parse(colorHex);
  return Color(parsedHex);
}