import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editprofil.dart';
import 'register_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  /// ================= LOAD DATA =================
  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '-';
      email = prefs.getString('email') ?? '-';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// AVATAR
              const CircleAvatar(
                radius: 42,
                backgroundColor: Color(0xFF23264A),
                child: Icon(
                  Icons.person,
                  size: 48,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 12),

              /// NAME & EMAIL
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: const TextStyle(color: Colors.white54),
              ),

              const SizedBox(height: 20),

              /// INFO CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF23264A),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Untuk hasil analisa yang lebih baik, lakukan pelacakan tidur minimal 30 hari.',
                  style: TextStyle(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 30),

              /// MENU
              menuItem(
                icon: Icons.person_outline,
                title: 'Detail profil',
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
                    ),
                  );
                  loadProfile();
                },
              ),

              menuItem(
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                onTap: () {},
              ),

              menuItem(
                icon: Icons.feedback_outlined,
                title: 'Feedback',
                onTap: () {},
              ),

              const Spacer(),

              /// LOGOUT
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1C1F3B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    /// HAPUS SEMUA DATA LOGIN
                    await prefs.clear();

                    if (!mounted) return;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterScreen(),
                      ),
                          (route) => false,
                    );
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= MENU ITEM =================
  Widget menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF23264A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.white70),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.white54,
        ),
      ),
    );
  }
}
