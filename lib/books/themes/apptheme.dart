import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  fontFamily: GoogleFonts.josefinSans().fontFamily,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
);

ThemeData darkMode = ThemeData(
  fontFamily: GoogleFonts.josefinSans().fontFamily,
  colorScheme: ColorScheme.dark(
    background: const Color.fromARGB(255, 20, 20, 20),
    primary: Colors.grey.shade900,
    secondary: Colors.grey.shade600,
    inversePrimary: Colors.white,
  ),
);
