import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // warna biru tua
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              const Text(
                "Good Morning!",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Elfrika marceline Sinaga",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),

              // Ideal Sleep Card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2DC4B6),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ideal hours for sleep",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "8 hours 30 minutes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Start Tracking",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Image Sleepy Panda (pastikan ada di assets)
                    Image.asset(
                      'assets/images/panda.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Schedule Section
              const Text(
                "Your Schedule",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Calendar Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i = 10; i <= 14; i++)
                    Container(
                      decoration: BoxDecoration(
                        color: i == 13 ? Colors.amber : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      child: Column(
                        children: [
                          Text(
                            ["Wed", "Thu", "Fri", "Sat", "Sun"][i - 10],
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "$i",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 20),

              // Schedule Cards
              _buildScheduleCard(
                title: "No phone before bed,",
                time: "08:00pm",
                subtitle: "Avoid screens before sleeping",
                image: "assets/images/phone_off.jpeg",
              ),
              const SizedBox(height: 14),
              _buildScheduleCard(
                title: "Meditation,",
                time: "08:00pm",
                subtitle: "In 20 minutes",
                image: "assets/images/meditation.jpeg",
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: const Color(0xFF1B263B),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nightlight_round),
            label: "Program",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Statistic",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  // custom widget untuk card jadwal
  Widget _buildScheduleCard({
    required String title,
    required String time,
    required String subtitle,
    required String image,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1B263B),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset(image, width: 50, height: 50),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title $time",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: true,
            onChanged: (val) {},
            activeColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
