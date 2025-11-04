import 'package:flutter/material.dart';
import 'home_screen.dart'; // pastikan path sesuai dengan struktur project-mu

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  double weight = 60;

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
              'Terakhir,',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 6),
            const Text(
              'Berapa berat badan mu?',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 30),

            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2D4E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${weight.toInt()} Kg',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),

            Slider(
              activeColor: const Color(0xFF009688),
              inactiveColor: Colors.white24,
              min: 30,
              max: 150,
              value: weight,
              onChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
            ),

            const Spacer(),

            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // tampilkan notifikasi dulu
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Color(0xFF009688),
                      content: Text('Data kamu sudah lengkap! 🎉'),
                    ),
                  );

                  // pindah ke halaman home setelah 1 detik
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009688),
                  minimumSize: const Size(120, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Selesai'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
