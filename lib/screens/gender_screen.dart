import 'package:flutter/material.dart';
import 'birthdate_screen.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String selectedGender = '';

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
              'Hi!',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 6),
            const Text(
              'Pilih gender kamu, agar kami bisa mengenal kamu lebih baik.',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 30),

            // Tombol Pilihan Gender
            genderOption('Wanita', Icons.female),
            const SizedBox(height: 16),
            genderOption('Pria', Icons.male),

            const Spacer(),

            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: selectedGender.isNotEmpty
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BirthdateScreen(),
                    ),
                  );
                }
                    : null,
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

  Widget genderOption(String gender, IconData icon) {
    final isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2D4E),
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: const Color(0xFF009688), width: 2)
              : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              gender,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
