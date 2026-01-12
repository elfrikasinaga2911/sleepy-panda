import 'package:flutter/material.dart';
import '../services/sleep_service.dart';
import 'sleeping_screen.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  int hour = 7;
  int minute = 30;

  Widget wheel(List<int> items, int value, Function(int) onChanged) {
    return SizedBox(
      width: 80,
      height: 200,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (i) => onChanged(items[i]),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: items.length,
          builder: (_, index) {
            final selected = items[index] == value;
            return Center(
              child: Text(
                items[index].toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: selected ? 30 : 18,
                  color: selected ? Colors.white : Colors.white54,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _sleepNow() async {
    final now = DateTime.now();

    DateTime wakeTime = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // kalau jam bangun lebih kecil dari jam tidur → besok
    if (wakeTime.isBefore(now)) {
      wakeTime = wakeTime.add(const Duration(days: 1));
    }

    /// SIMPAN KE HIVE
    await SleepService.saveSleep(
      sleepTime: now,
      wakeTime: wakeTime,
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SleepingScreen(
          hour: hour,
          minute: minute,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2341),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              'Pilih waktu bangun tidur mu',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                wheel(
                  List.generate(24, (i) => i),
                  hour,
                      (v) => setState(() => hour = v),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(':',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                ),
                wheel(
                  List.generate(60, (i) => i),
                  minute,
                      (v) => setState(() => minute = v),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Text(
              'Waktu tidur ideal yang cukup adalah\nselama 8 jam',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A8A8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: _sleepNow,
                child: const Text('Tidur sekarang'),
              ),
            ),

            const SizedBox(height: 12),
            const Text('Nanti saja', style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}
