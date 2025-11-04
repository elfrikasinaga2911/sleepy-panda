import 'package:flutter/material.dart';
import 'package:sleepy_panda/screens/splash_screen.dart';

void main() {
  runApp(const SleepyPandaApp());
}

class SleepyPandaApp extends StatelessWidget {
  const SleepyPandaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleepy Panda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1C1F3B),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
    );
  }
}

// ELFRIKA SARI M SINAGA
// 41823010076
