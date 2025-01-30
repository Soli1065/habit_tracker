import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool isCompleted;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  int streak;

  @HiveField(4)
  String category;

  @HiveField(5)
  List<int> repeatDays; // [0 = Sunday, 1 = Monday, ..., 6 = Saturday]

  Habit({
    required this.name,
    this.isCompleted = false,
    required this.createdAt,
    this.streak = 0,
    required this.category,
    required this.repeatDays
  });
}