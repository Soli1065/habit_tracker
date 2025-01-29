import 'package:hive/hive.dart';
import '../models/habit.dart';

class HabitDB {
  static const String boxName = 'habitsBox';

  static Future<void> init() async {
    Hive.registerAdapter(HabitAdapter());
    await Hive.openBox<Habit>(boxName);
  }

  static Box<Habit> _getBox() => Hive.box<Habit>(boxName);

  static List<Habit> getHabits() => _getBox().values.toList();

  static void addHabit(Habit habit) => _getBox().add(habit);

  static void updateHabit(int index, Habit habit) => _getBox().putAt(index, habit);

  static void deleteHabit(int index) => _getBox().deleteAt(index);
}