import 'package:flutter/material.dart';

import 'font_maneger.dart';

TextStyle _getTextStyle(
    double fontSize, FontWeight fontWeight, Color color, String fontFamily) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// regular style

TextStyle getRegularStyle(
    {double fontSize = FontSizeManager.s16,
    required Color color,
    required String fontFamily}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color, fontFamily);
}

// medium style

TextStyle getMediumStyle(
    {double fontSize = FontSizeManager.s16,
    required Color color,
    required String fontFamily}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color, fontFamily);
}

// medium style

TextStyle getLightStyle(
    {double fontSize = FontSizeManager.s16,
    required Color color,
    required String fontFamily}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color, fontFamily);
}

// bold style

TextStyle getBoldStyle(
    {double fontSize = FontSizeManager.s22,
    required Color color,
    required String fontFamily}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color, fontFamily);
}

// semibold style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSizeManager.s16,
    required Color color,
    required String fontFamily}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color, fontFamily);
}
