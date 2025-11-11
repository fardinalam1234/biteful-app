import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// === COLOR TOKENS ===
const kPrimary = Color(0xFF284B63);
const kPrimaryLight = Color(0xFF8EADC3);
const kOnPrimary = Color(0xFFF4F9E9);
const kTextDark = Color(0xFF1E1E1E);
const kStar = Color(0xFFE4AB61);
const kPrimaryDark = Color(0xFF1E394B);

// === SHADOW TOKENS ===
final kCardShadow = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.25),
    offset: Offset(0, 4),
    blurRadius: 4,
  )
];

// === RADIUS TOKENS ===
const kCardRadius = 10.0;
const kPillRadius = 20.0;

// === THEME BUILDER ===
ThemeData buildBitefulTheme({
  required TextStyle amiko,
  required TextStyle mogra,
  required TextStyle inter,
}) {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: kPrimary,
      primary: kPrimary,
      onPrimary: kOnPrimary,
      surface: Color(0xFFF6F8FA),
      onSurface: kTextDark,
    ),
    useMaterial3: true,
  );

  return base.copyWith(
    textTheme: GoogleFonts.amikoTextTheme(base.textTheme).apply(
      bodyColor: kTextDark,
      displayColor: kTextDark,
    ),
    primaryTextTheme:
        GoogleFonts.amikoTextTheme(base.primaryTextTheme).apply(
      bodyColor: kOnPrimary,
      displayColor: kOnPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kPrimary,
      foregroundColor: kOnPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.mogra(
        fontSize: 22,
        color: kOnPrimary,
        letterSpacing: 1.2,
      ),
      iconTheme: const IconThemeData(
        color: kOnPrimary,
      ),
    ),
  );
}
