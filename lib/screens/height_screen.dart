import 'package:flutter/material.dart';
import 'weight_screen.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  double height = 165;

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
              'Selanjutnya,',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 6),
            const Text(
              'Berapa tinggi badan mu?',
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
                  '${height.toInt()} Cm',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),

            Slider(
              activeColor: const Color(0xFF009688),
              inactiveColor: Colors.white24,
              min: 100,
              max: 220,
              value: height,
              onChanged: (value) {
                setState(() {
                  height = value;
                });
              },
            ),

            const Spacer(),

            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WeightScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009688),
                  minimumSize: const Size(120, 45),
                ),
                child: const Text('Lanjut'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
