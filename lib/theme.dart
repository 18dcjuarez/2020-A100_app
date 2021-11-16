import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;

// MAIN APP COLORS
const Color incidenciasIPN = Color(0xFF6D1A42);
const Color incidenciasRed = Color(0xFF9F1125);
const Color incidenciasGreen = Color(0xFF16BB2D);
const Color incidenciasAmber = Color(0xFFF39302);
const Color incidenciasBlack = Color(0xFF1B1B26);
const Color incidenciasLightBlue = Color(0xFF5081CA);
const Color incidenciasDarkBlue = Color(0xFF13305A);
const Color incidenciasDarkGreen = Color(0xFF184B22);
const Color incidenciasLightestGrey = Color(0xFFF1F1F1);
const Color incidenciasLightGrey = Color(0xFFDCDCDC);
const Color incidenciasDarkGrey = Color(0xFF6A6A73);

class GestionTheme {
  static get theme {
    final textTheme = TextTheme(
      bodyText1: TextStyle(
        fontSize: 16.w,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        fontSize: 13.w,
        color: Colors.white,
      ),
      headline1: TextStyle(
        fontSize: 20.w,
        color: Colors.white,
      ),
      headline2: TextStyle(
        fontSize: 23.w,
        color: Colors.white,
      ),
      headline3: TextStyle(
        fontSize: 38.w,
      ),
      headline4: TextStyle(
        fontSize: 18.w,
        color: Colors.black,
      ),
      caption: TextStyle(
        fontSize: 11.5.w,
        color: Colors.black,
      ),
    );
    return ThemeData(
      fontFamily: 'Visby',
      accentColor: Colors.white,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
