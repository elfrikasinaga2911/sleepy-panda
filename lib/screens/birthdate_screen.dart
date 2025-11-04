import 'package:flutter/material.dart';
import 'height_screen.dart';

class BirthdateScreen extends StatefulWidget {
  const BirthdateScreen({super.key});

  @override
  State<BirthdateScreen> createState() => _BirthdateScreenState();
}

class _BirthdateScreenState extends State<BirthdateScreen> {
  DateTime selectedDate = DateTime(2000, 1, 1);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1960),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF009688),
              onPrimary: Colors.white,
              surface: Color(0xFF1C1F3B),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
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
              'Terima kasih!',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 6),
            const Text(
              'Sekarang, kapan tanggal lahir mu?',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 30),

            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2D4E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${selectedDate.day.toString().padLeft(2, '0')} / '
                      '${selectedDate.month.toString().padLeft(2, '0')} / '
                      '${selectedDate.year}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const Spacer(),

            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HeightScreen()),
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
