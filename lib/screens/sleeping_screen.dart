import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:sleepy_panda/main.dart';

class SleepingScreen extends StatefulWidget {
  final int hour;
  final int minute;

  const SleepingScreen({
    super.key,
    required this.hour,
    required this.minute,
  });

  @override
  State<SleepingScreen> createState() => _SleepingScreenState();
}

class _SleepingScreenState extends State<SleepingScreen> {
  String name = '';
  late DateTime sleepStartTime;

  @override
  void initState() {
    super.initState();
    sleepStartTime = DateTime.now(); // ⏱️ mulai tidur
    loadName();
    scheduleAlarm();
  }

  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'User';
    });
  }

  Future<void> scheduleAlarm() async {
    final now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime alarmTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      widget.hour,
      widget.minute,
    );

    if (alarmTime.isBefore(now)) {
      alarmTime = alarmTime.add(const Duration(days: 1));
    }

    await notifications.zonedSchedule(
      0,
      'Waktunya Bangun',
      'Selamat pagi, $name',
      alarmTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel',
          'Alarm',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('alarm'),
          playSound: true,
          fullScreenIntent: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// 📌 Simpan durasi tidur lalu kembali ke Home
  Future<void> wakeUp() async {
    final prefs = await SharedPreferences.getInstance();

    final wakeTime = DateTime.now();
    final durationMinutes =
        wakeTime.difference(sleepStartTime).inMinutes;

    await prefs.setInt('last_sleep_minutes', durationMinutes);
    await prefs.setString(
        'last_sleep_start', sleepStartTime.toIso8601String());
    await prefs.setString(
        'last_sleep_end', wakeTime.toIso8601String());

    Navigator.pop(context); // kembali ke Home
  }

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now();

    return Scaffold(
      backgroundColor: const Color(0xFF1C2341),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: wakeUp, // 👈 KLIK DI MANA SAJA
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const SizedBox(height: 80),
              Text(
                'Selamat tidur, $name',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const Spacer(),
              Text(
                '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Waktu bangun: ${widget.hour.toString().padLeft(2, '0')}:${widget.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(color: Colors.white54),
              ),
              const Spacer(),
              const Column(
                children: [
                  Icon(Icons.keyboard_arrow_up, color: Colors.white54),
                  Icon(Icons.keyboard_arrow_up, color: Colors.white54),
                  Text(
                    'Geser ke atas untuk bangun',
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
