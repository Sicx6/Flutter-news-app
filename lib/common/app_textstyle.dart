import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle mainText() {
    return GoogleFonts.alata(
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle mainText2() {
    return GoogleFonts.bigshotOne(
        fontSize: 30, fontWeight: FontWeight.w700, color: Colors.deepPurple);
  }

  static TextStyle abezee() {
    return GoogleFonts.aBeeZee(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle seeMore() {
    return const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w300, color: Colors.grey);
  }
}
