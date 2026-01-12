import 'package:flutter/material.dart';
import '../utils/user_preferences.dart';
import 'gender_screen.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController nameController = TextEditingController();
  bool _isNavigating = false;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> _saveAndNext() async {
    if (_isNavigating) return;

    final name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama tidak boleh kosong'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    _isNavigating = true;

    final oldData = await UserPreferences.getUser();

    await UserPreferences.saveUser(
      name: name,
      gender: oldData['gender'],
      height: oldData['height'],
      weight: oldData['weight'],
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GenderScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
          _saveAndNext();
        },
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Text(
                'Selamat datang di Sleepy Panda!',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 6),
              const Text(
                'Kita kenalan dulu yuk! Siapa nama kamu?',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: nameController,
                autofocus: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _saveAndNext(),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF2A2D4E),
                  hintText: 'Nama',
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const Spacer(),
              const Center(
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
}