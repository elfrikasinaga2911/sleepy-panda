import 'package:flutter/material.dart';
import '../utils/user_preferences.dart';
import 'birthdate_screen.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String selectedGender = '';
  bool _isNavigating = false;

  /// ================= SAVE & NEXT =================
  Future<void> _saveAndNext() async {
    if (_isNavigating) return;
    if (selectedGender.isEmpty) return;

    _isNavigating = true;

    await UserPreferences.saveUser(
      gender: selectedGender,
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const BirthdateScreen()),
    );
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),

      /// LISTENER → tangkap tap di mana saja
      body: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) {
          _saveAndNext();
        },

        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),

              const Text(
                'Hi!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Pilih gender kamu, agar kami bisa mengenal kamu lebih baik.',
                style: TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 30),

              /// ===== PILIHAN GENDER =====
              genderOption('Wanita', Icons.female),
              const SizedBox(height: 16),
              genderOption('Pria', Icons.male),

              const Spacer(),

              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Tap di mana saja untuk lanjut',
                  style: TextStyle(color: Colors.white38),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= GENDER OPTION =================
  Widget genderOption(String gender, IconData icon) {
    final isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });

        /// auto lanjut setelah pilih
        Future.delayed(const Duration(milliseconds: 150), _saveAndNext);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2D4E),
          borderRadius: BorderRadius.circular(12),
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}