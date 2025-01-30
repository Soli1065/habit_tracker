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

  @HiveField(6)
  String habitType; // "Checkbox", "Numeric", "Timer"

  @HiveField(7)
  int? goalValue; // For numeric or timer-based habits

  @HiveField(8)
  int? progressValue; // Current progress

  @HiveField(9)
  int xp; // User earns XP for completing habits

  @HiveField(10)
  int level; // Level up after gaining enough XP



  Habit({
    required this.name,
    this.isCompleted = false,
    required this.createdAt,
    this.streak = 0,
    required this.category,
    required this.repeatDays,
    required this.habitType,
    this.goalValue,
    this.progressValue,
    this.xp = 0,
    this.level = 0
  });


  Habit copyWith({
    String? name,
    bool? isCompleted,
    DateTime? createdAt,
    int? streak,
    String? category,
    List<int>? repeatDays,
    String? habitType,
    int? goalValue,
    int? progressValue,
    int? xp,
    int? level
  }) {
    return Habit(
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      streak: streak ?? this.streak,
      category: category ?? this.category,
      repeatDays: repeatDays ?? this.repeatDays,
      habitType: habitType ?? this.habitType,
      goalValue: goalValue ?? this.goalValue,
      progressValue: progressValue ?? this.progressValue,
      xp: xp ?? this.xp,
      level: level ?? this.level
    );
  }

}