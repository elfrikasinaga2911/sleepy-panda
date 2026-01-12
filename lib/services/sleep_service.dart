import 'package:hive/hive.dart';
import '../models/sleep_record.dart';

class SleepService {
  static final Box<SleepRecord> _box =
  Hive.box<SleepRecord>('sleep');

  /// SIMPAN DATA TIDUR
  static Future<void> saveSleep({
    required DateTime sleepTime,
    required DateTime wakeTime,
  }) async {
    final duration =
        wakeTime.difference(sleepTime).inMinutes;

    final record = SleepRecord(
      sleepTime: sleepTime,
      wakeTime: wakeTime,
      durationMinutes: duration,
    );

    await _box.add(record);
  }

  /// AMBIL SEMUA DATA
  static List<SleepRecord> getAllSleep() {
    return _box.values.toList();
  }

  /// DATA TERAKHIR
  static SleepRecord? getLastSleep() {
    if (_box.isEmpty) return null;
    return _box.values.last;
  }
}
