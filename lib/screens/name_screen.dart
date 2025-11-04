import 'package:flutter/material.dart';
import 'gender_screen.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Text('Selamat datang di Sleepy Panda!',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 6),
            const Text('Kita kenalan dulu yuk! Siapa nama kamu?',
                style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 30),
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF2A2D4E),
                hintText: 'Nama',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const GenderScreen()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688),
                    minimumSize: const Size(120, 45)),
                child: const Text('Lanjut'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
