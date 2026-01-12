import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'height_screen.dart';

class BirthdateScreen extends StatefulWidget {
  const BirthdateScreen({super.key});

  @override
  State<BirthdateScreen> createState() => _BirthdateScreenState();
}

class _BirthdateScreenState extends State<BirthdateScreen> {
  int day = 1;
  int month = 1;
  int year = 2000;

  bool _isNavigating = false;

  final List<int> days = List.generate(31, (i) => i + 1);
  final List<int> months = List.generate(12, (i) => i + 1);
  final List<int> years =
  List.generate(DateTime.now().year - 1950 + 1, (i) => 1950 + i);

  /// ================= SAVE & NEXT =================
  Future<void> _saveAndNext() async {
    if (_isNavigating) return;
    _isNavigating = true;

    final prefs = await SharedPreferences.getInstance();
    final birthdate = DateTime(year, month, day);

    await prefs.setString(
      'birthdate',
      birthdate.toIso8601String(),
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HeightScreen()),
    );
  }

  /// ================= PICKER =================
  Widget picker({
    required List<int> items,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Expanded(
      child: SizedBox(
        height: 150,
        child: ListWheelScrollView.useDelegate(
          itemExtent: 45,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {
            onChanged(items[index]);
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              final item = items[index];
              final isSelected = item == value;
              return Center(
                child: Text(
                  item.toString().padLeft(2, '0'),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white54,
                    fontSize: isSelected ? 22 : 16,
                    fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            },
            childCount: items.length,
          ),
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
                      'Terima kasih!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Scroll untuk memilih tanggal lahir kamu',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// 🚫 PICKER AREA → AMAN DARI TAP
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2D4E),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                picker(
                  items: days,
                  value: day,
                  onChanged: (v) => setState(() => day = v),
                ),
                picker(
                  items: months,
                  value: month,
                  onChanged: (v) => setState(() => month = v),
                ),
                picker(
                  items: years,
                  value: year,
                  onChanged: (v) => setState(() => year = v),
                ),
              ],
            ),
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
