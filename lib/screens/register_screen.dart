import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'name_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
        child: Column(
          children: [
            Image.asset('assets/images/panda.png', width: 100),
            const SizedBox(height: 15),
            const Text('Daftar menggunakan email yang valid',
                style: TextStyle(color: Colors.white)),
            const SizedBox(height: 30),
            TextField(
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF2A2D4E),
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF2A2D4E),
                hintText: 'Password',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const NameScreen()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009688),
                  minimumSize: const Size(double.infinity, 50)),
              child: const Text('Daftar'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              child: const Text('Sudah punya akun? Masuk sekarang',
                  style: TextStyle(color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }
}
