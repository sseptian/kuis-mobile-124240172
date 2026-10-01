import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const UniqloApp());
}

class UniqloApp extends StatelessWidget {
  const UniqloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kuis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFFE60012),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE60012),
          primary: const Color(0xFFE60012),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0.5,
        ),
      ),
      home: const LoginPage(),
    );
  }
}
