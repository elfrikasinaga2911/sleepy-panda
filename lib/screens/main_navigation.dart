import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'sleep_screen.dart';
import 'profil.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    SleepScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),

      // ================= CONTENT =================
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF23264A),
        selectedItemColor: const Color(0xFFFFC107),
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Jurnal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nightlight_round),
            label: 'Sleep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
