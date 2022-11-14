import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomConstants {
  final String title = 'Find your dream job';
  final String assetImage = 'assets/images/profile.png';
  bool initHiveDB = false;
  TextStyle textStyle(
      {required Color color,
      required bool isDarkMode,
      required double fontSize,
      FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
        color: isDarkMode ? Colors.white : color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal);
  }
}
