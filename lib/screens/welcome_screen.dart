import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset('assets/images/panda.png', width: 120),
                const SizedBox(height: 10),
                const Text(
                  'Sleepy Panda',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Mulai dengan masuk atau mendaftar untuk melihat analisa tidur mu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009688),
                      minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Masuk'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                  },
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Daftar', style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
