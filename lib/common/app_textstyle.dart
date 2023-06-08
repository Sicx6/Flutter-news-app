import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle mainText({double fontSize = 20}) {
    return GoogleFonts.alata(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle mainText2() {
    return GoogleFonts.bigshotOne(
        fontSize: 30, fontWeight: FontWeight.w700, color: Colors.deepPurple);
  }

  static TextStyle abezee(
      {double fontSize = 20,
      var fontWeight = FontWeight.w700,
      Color color = Colors.black}) {
    return GoogleFonts.aBeeZee(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle seeMore(
      {double fontSize = 16,
      var fontWeight = FontWeight.w300,
      Color textColor = Colors.grey}) {
    return TextStyle(
        fontSize: fontSize, fontWeight: fontWeight, color: textColor);
  }
}
