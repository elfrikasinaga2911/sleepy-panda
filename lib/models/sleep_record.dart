import 'package:hive/hive.dart';

part 'sleep_record.g.dart';

@HiveType(typeId: 0)
class SleepRecord extends HiveObject {
  @HiveField(0)
  DateTime sleepTime;

  @HiveField(1)
  DateTime wakeTime;

  @HiveField(2)
  int durationMinutes;

  SleepRecord({
    required this.sleepTime,
    required this.wakeTime,
    required this.durationMinutes,
  });
}
