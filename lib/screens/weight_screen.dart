import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_navigation.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  double weight = 50;
  bool _isNavigating = false;

  Future<void> _finishOnboarding() async {
    if (_isNavigating) return;
    _isNavigating = true;

    try {
      final prefs = await SharedPreferences.getInstance();

      // SIMPAN BERAT BADAN
      await prefs.setDouble('weight', weight);

      // TANDAI ONBOARDING SELESAI
      await prefs.setBool('onboarding_complete', true);

      if (!mounted) return;

      // MASUK KE APP UTAMA (HAPUS SEMUA STACK)
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigation()),
            (route) => false,
      );
    } catch (e) {
      debugPrint('ERROR FINISH ONBOARDING: $e');
      _isNavigating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),

            const Text(
              'Berapa berat badan kamu?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Data ini membantu kami memberikan rekomendasi terbaik.',
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 40),

            Center(
              child: Text(
                '${weight.toInt()} kg',
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Slider(
              value: weight,
              min: 30,
              max: 150,
              divisions: 120,
              label: '${weight.toInt()}',
              onChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _finishOnboarding,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Selesai',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
