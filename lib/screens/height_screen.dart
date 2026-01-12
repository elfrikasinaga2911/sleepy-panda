import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'weight_screen.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  int height = 165;
  bool _isNavigating = false;

  final List<int> heights = List.generate(250 - 150 + 1, (i) => 150 + i);

  /// ================= SAVE & NEXT =================
  Future<void> _saveAndNext() async {
    if (_isNavigating) return;
    _isNavigating = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', height.toDouble());

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const WeightScreen()),
    );
  }

  /// ================= PICKER =================
  Widget heightPicker() {
    return SizedBox(
      height: 180,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 45,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          setState(() {
            height = heights[index];
          });
        },
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: heights.length,
          builder: (context, index) {
            final value = heights[index];
            final isSelected = value == height;
            return Center(
              child: Text(
                '$value cm',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white54,
                  fontSize: isSelected ? 24 : 16,
                  fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),

      body: Column(
        children: [
          /// 🔥 AREA ATAS → TAP UNTUK NEXT
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _saveAndNext,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 100),
                    Text(
                      'Selanjutnya,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Scroll untuk memilih tinggi badan',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// 🚫 PICKER AREA → TIDAK MEMICU NAVIGASI
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 20,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2D4E),
              borderRadius: BorderRadius.circular(16),
            ),
            child: heightPicker(),
          ),

          /// 🔥 AREA BAWAH → TAP UNTUK NEXT
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _saveAndNext,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'Tap di mana saja untuk lanjut',
                style: TextStyle(color: Colors.white38),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
