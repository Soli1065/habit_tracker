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

  Habit({
    required this.name,
    this.isCompleted = false,
    required this.createdAt,
    this.streak = 0,
    required this.category
  });
}