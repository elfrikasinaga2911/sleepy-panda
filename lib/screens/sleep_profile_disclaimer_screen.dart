import 'package:flutter/material.dart';
import 'sleep_profile_page_view.dart';

class SleepProfileDisclaimerScreen extends StatelessWidget {
  const SleepProfileDisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              /// ================= TITLE =================
              const Text(
                'Sebelum melanjutkan..',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 30),

              /// ================= CHECKLIST =================
              _checkItem(
                'Sleepy Panda bertujuan untuk memberikan edukasi dan informasi. '
                    'Sleepy Panda berusaha memberikan pemahaman lebih tentang pola tidur kamu. '
                    'Namun, Sleepy Panda bukanlah alat diagnostik atau pengganti konsultasi dengan dokter.',
              ),

              _checkItem(
                'Profil tidur yang disediakan oleh Sleepy Panda berdasarkan data tidur yang kamu '
                    'berikan dan bertujuan untuk memberikan rekomendasi terkait pola tidur atau potensi kesehatan.',
              ),

              _checkItem(
                'Kami selalu menyarankan untuk berkonsultasi dengan dokter atau ahli tidur '
                    'jika mengalami masalah tidur yang serius atau berkelanjutan.',
              ),

              _checkItem(
                'Hasil profil tidur dapat berubah seiring waktu.',
              ),

              const Spacer(),

              /// ================= BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C2A8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SleepProfilePageView(),
                      ),
                    );
                  },
                  child: const Text(
                    'Ya, saya mengerti',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= CHECK ITEM =================
  static Widget _checkItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
