import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'name_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  /// ================= SAVE REGISTER =================
  Future<void> saveRegisterData() async {
    final email = emailController.text.trim();
    final password = passController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password wajib diisi'),
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password minimal 6 karakter'),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('is_logged_in', false);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const NameScreen()),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
        child: Column(
          children: [
            Image.asset('assets/images/panda.png', width: 100),
            const SizedBox(height: 15),

            const Text(
              'Daftar menggunakan email yang valid',
              style: TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 30),

            /// EMAIL
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF2A2D4E),
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon:
                const Icon(Icons.email, color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// PASSWORD
            TextField(
              controller: passController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF2A2D4E),
                hintText: 'Password',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon:
                const Icon(Icons.lock, color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// BUTTON DAFTAR
            ElevatedButton(
              onPressed: saveRegisterData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009688),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Daftar'),
            ),

            const SizedBox(height: 12),

            /// KE LOGIN
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const LoginScreen()),
                );
              },
              child: const Text(
                'Sudah punya akun? Masuk sekarang',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
