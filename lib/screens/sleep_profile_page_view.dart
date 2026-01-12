import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'main_navigation.dart';

class SleepProfilePageView extends StatefulWidget {
  const SleepProfilePageView({super.key});

  @override
  State<SleepProfilePageView> createState() => _SleepProfilePageViewState();
}

class _SleepProfilePageViewState extends State<SleepProfilePageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _backToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// JUDUL
            const Text(
              'Profil Tidur Kamu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            /// PAGE VIEW
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: const [
                  _ProfileBaikPage(),
                  _ProfileApneaPage(),
                  _ProfileInsomniaPage(),
                ],
              ),
            ),

            /// DOT INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                    (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 14 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? const Color(0xFF00C2A8)
                        : Colors.white30,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _backToHome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C2A8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Kembali ke Jurnal Tidur',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// PAGE — BAIK
class _ProfileBaikPage extends StatelessWidget {
  const _ProfileBaikPage();

  @override
  Widget build(BuildContext context) {
    return _ProfileTemplate(
      icon: '🚀',
      title: 'Baik',
      color: Colors.green,
      description:
      'Selamat, kamu memiliki profil tidur yang baik.\n\n'
          'Kamu dapat tidur dengan nyenyak dan tanpa atau dengan sedikit gangguan.',
      tips: const [
        'Tetap jaga rutinitas tidur yang konsisten',
        'Pastikan lingkungan tidur nyaman, gelap, sejuk, dan tenang',
        'Hindari penggunaan smartphone di tempat tidur',
        'Lakukan aktivitas fisik secara teratur',
        'Hindari makan besar sebelum tidur',
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// PAGE — SLEEP APNEA
class _ProfileApneaPage extends StatelessWidget {
  const _ProfileApneaPage();

  @override
  Widget build(BuildContext context) {
    return _ProfileTemplate(
      icon: '😴',
      title: 'Potensi gangguan: Sleep Apnea',
      color: Colors.orange,
      description:
      'Kamu berpotensi memiliki gangguan sleep apnea.\n\n'
          'Segera konsultasikan dengan dokter untuk penanganan lebih lanjut.',
      tips: const [
        'Konsultasi dengan dokter',
        'Hindari alkohol dan rokok',
        'Tidur dengan posisi miring',
        'Olahraga secara teratur',
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// PAGE — INSOMNIA
class _ProfileInsomniaPage extends StatelessWidget {
  const _ProfileInsomniaPage();

  @override
  Widget build(BuildContext context) {
    return _ProfileTemplate(
      icon: '😔',
      title: 'Potensi gangguan: Insomnia',
      color: Colors.redAccent,
      description:
      'Kamu berpotensi mengalami insomnia.\n\n'
          'Kesulitan tidur dapat memengaruhi aktivitas harian.',
      tips: const [
        'Atur jadwal tidur yang konsisten',
        'Hindari kafein sebelum tidur',
        'Lakukan relaksasi sebelum tidur',
        'Konsultasi dengan dokter bila berlanjut',
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// TEMPLATE CARD (RAPI & TIDAK DOBEL)
class _ProfileTemplate extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;
  final String description;
  final List<String> tips;

  const _ProfileTemplate({
    required this.icon,
    required this.title,
    required this.color,
    required this.description,
    required this.tips,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF23264A),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView(
          children: [
            /// STATUS
            Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// DESKRIPSI
            Text(
              description,
              style: const TextStyle(
                color: Colors.white70,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            /// SARAN
            const Text(
              'Saran untuk kamu:',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            /// CHECKLIST (HANYA SEKALI)
            ...tips.map(
                  (text) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF00C2A8),
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        text,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
