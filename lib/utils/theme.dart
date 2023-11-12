import 'package:flutter/material.dart';
import 'package:todo/utils/colors.dart';

ThemeData buildDarkTheme() {
  return ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
    primaryColorDark: primaryColor,
    primaryColor: primaryColor,
    primaryIconTheme: const IconThemeData(grade: -25, weight: 100),
    textTheme: ThemeData.dark().textTheme.copyWith(
          displayLarge: const TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 34,
              color: secondaryColor),
          displayMedium: const TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: secondaryColor),
          displaySmall: const TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.black),
          bodyLarge: const TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: secondaryColor),
          bodyMedium: const TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.black),
          bodySmall: const TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: secondaryColor),
        ),
  );
}

ThemeData buildLightTheme() {
  return ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
    primaryColorLight: primaryColor,
    primaryColor: primaryColor,
    primaryIconTheme: const IconThemeData(grade: -25, weight: 100),
    scaffoldBackgroundColor: secondaryColor,
    textTheme: ThemeData.light().textTheme.copyWith(
          displayLarge: const TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 34,
              color: Colors.black),
          displayMedium: const TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.black),
          displaySmall: const TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.black),
          bodyLarge: const TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.black),
          bodyMedium: const TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.black),
          bodySmall: const TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Colors.black),
        ),
  );
}
