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


  void completeHabit(int index) {
    var habit = state[index];
    int newXP = habit.xp + 10; // Earn 10 XP per completed habit
    int newLevel = habit.level;

    if (newXP >= 100) { // Level up every 100 XP
      newXP -= 100;
      newLevel += 1;
    }

    state[index] = habit.copyWith(
      isCompleted: true,
      streak: habit.streak + 1,
      xp: newXP,
      level: newLevel,
    );
  }

}