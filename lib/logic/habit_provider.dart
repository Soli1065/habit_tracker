import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/habit_db.dart';
import '../data/models/habit.dart';

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>((ref) {
  return HabitNotifier();
});

class HabitNotifier extends StateNotifier<List<Habit>> {
  HabitNotifier() : super(HabitDB.getHabits());

  void addHabit(Habit habit) {
    HabitDB.addHabit(habit);
    state = HabitDB.getHabits();
  }

  void updateHabit(int index, Habit habit) {
    HabitDB.updateHabit(index, habit);
    state = HabitDB.getHabits();
  }

  void deleteHabit(int index) {
    HabitDB.deleteHabit(index);
    state = HabitDB.getHabits();
  }
}