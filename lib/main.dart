// lib/main.dart - ГОТОВЫЙ КОД
import 'package:flutter/material.dart';
import 'main_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2048',
      theme: ThemeData(
        primaryColor: const Color(0xFF8F7A66),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(0xFF8F7A66, {
            50: const Color(0xFFF8F6F2),
            100: const Color(0xFFF1ECE5),
            200: const Color(0xFFE3D9CC),
            300: const Color(0xFFD4C6B2),
            400: const Color(0xFFC5B399),
            500: const Color(0xFF8F7A66),
            600: const Color(0xFF7A6857),
            700: const Color(0xFF645548),
            800: const Color(0xFF4F433A),
            900: const Color(0xFF39312B),
          }),
        ).copyWith(
          secondary: const Color(0xFFF67C5F),
        ),
        fontFamily: 'Arial',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8F7A66),
          foregroundColor: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8F7A66),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Arial',
            ),
            elevation: 4,
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Color(0xFF776E65),
          ),
          headlineMedium: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF776E65),
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Color(0xFF776E65),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFF776E65),
          ),
        ),
      ),
      home: const MainMenuPage(),
    );
  }
}