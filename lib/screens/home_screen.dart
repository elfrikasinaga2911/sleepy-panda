import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/sleep_record.dart';
import '../services/sleep_service.dart';
import 'sleep_profile_disclaimer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1F3B),

        appBar: AppBar(
          backgroundColor: const Color(0xFF1C1F3B),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Jurnal Tidur',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFF00C2A8),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            tabs: [
              Tab(text: 'Daily'),
              Tab(text: 'Week'),
              Tab(text: 'Month'),
            ],
          ),
        ),

        body: const TabBarView(
          children: [
            DailyView(),
            Center(child: Text('Week', style: TextStyle(color: Colors.white54))),
            Center(child: Text('Month', style: TextStyle(color: Colors.white54))),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////
// ================= DAILY =================
class DailyView extends StatelessWidget {
  const DailyView({super.key});

  @override
  Widget build(BuildContext context) {
    final records = SleepService.getAllSleep();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        /// INFO CARD
        _infoCard(context),

        const SizedBox(height: 20),

        /// LIST DATA TIDUR
        if (records.isEmpty)
          const Center(
            child: Text(
              'Belum ada data tidur',
              style: TextStyle(color: Colors.white54),
            ),
          )
        else
          ...records.map((record) => _sleepCard(record)),
      ],
    );
  }

  /// ================= INFO CARD =================
  Widget _infoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF23264A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Untuk hasil analisa yang lebih baik, akurat, dan bermanfaat. '
                'Profil tidur hanya bisa diakses setelah kamu melakukan pelacakan '
                'tidur paling tidak 30 hari.',
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SleepProfileDisclaimerScreen(),
                  ),
                );
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF00C2A8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Lihat profil tidur',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= CARD DATA =================
  Widget _sleepCard(SleepRecord record) {
    final date = DateFormat('dd MMMM yyyy').format(record.sleepTime);

    final sleep = DateFormat('HH:mm').format(record.sleepTime);
    final wake = DateFormat('HH:mm').format(record.wakeTime);

    final hours = record.durationMinutes ~/ 60;
    final minutes = record.durationMinutes % 60;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF23264A),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              /// DURASI
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.alarm, color: Colors.white),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Durasi tidur',
                          style:
                          TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        Text(
                          '$hours jam $minutes menit',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// WAKTU
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.wb_sunny, color: Colors.white),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Waktu tidur',
                          style:
                          TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        Text(
                          '$sleep - $wake',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
