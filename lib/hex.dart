import 'package:flutter/material.dart';

class Hex {
  //Hex Number To Color
  static Color intToColor(int hexNumber) => Color.fromARGB(
      255,
      (hexNumber >> 16) & 0xFF,
      ((hexNumber >> 8) & 0xFF),
      (hexNumber >> 0) & 0xFF);

  //String To Hex Number
  static int stringToInt(String hex) => int.parse(hex, radix: 16);

  //String To Color
  static String colorToString(Color color) =>
      _colorToString(color.red.toRadixString(16)) +
      _colorToString(color.green.toRadixString(16)) +
      _colorToString(color.blue.toRadixString(16));
  static String _colorToString(String text) =>
      text.length == 1 ? "0" + text : text;

  //Subste
  static String textSubString(String text) {
    if (text == null) return null;

    if (text.length < 6) return null;

    if (text.length == 6) return text;

    return text.substring(text.length - 6, 6);
  }
}
