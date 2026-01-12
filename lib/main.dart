import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'screens/welcome_screen.dart';
import 'screens/main_navigation.dart';
import 'models/sleep_record.dart';

final FlutterLocalNotificationsPlugin notifications =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// ================= INIT TIMEZONE =================
  tz.initializeTimeZones();

  /// ================= INIT NOTIFICATION =================
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
  InitializationSettings(android: androidSettings);

  await notifications.initialize(initSettings);

  /// ================= INIT HIVE =================
  await Hive.initFlutter();
  Hive.registerAdapter(SleepRecordAdapter());
  await Hive.openBox<SleepRecord>('sleep');

  runApp(const SleepyPandaApp());
}

class SleepyPandaApp extends StatelessWidget {
  const SleepyPandaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sleepy Panda',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1C1F3B),
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: const AuthGate(),
    );
  }
}

/// ================= AUTH GATE =================
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.teal),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Terjadi kesalahan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        if (snapshot.data == true) {
          return const MainNavigation();
        }

        return const WelcomeScreen();
      },
    );
  }
}
