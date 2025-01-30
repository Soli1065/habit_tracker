import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/habit_provider.dart';
import '../data/models/habit.dart';
import '../widgets/habit_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  bool isTodayAHabitDay(Habit habit) {
    int today = DateTime.now().weekday - 1; // Convert Monday = 1 to 0-based index
    return habit.repeatDays.contains(today);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Habit Tracker')),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits[index];
          return HabitTile(
            habit: habit,
            onToggle: () {
              ref.read(habitProvider.notifier).updateHabit(
                index,
                habit.copyWith(isCompleted: !habit.isCompleted),
              );
            },
            onIncrement: () {
              if (habit.progressValue! < habit.goalValue!) {
                ref.read(habitProvider.notifier).updateHabit(
                  index,
                  habit.copyWith(progressValue: habit.progressValue! + 1),
                );
              }
            },
            onDecrement: () {
              if (habit.progressValue! > 0) {
                ref.read(habitProvider.notifier).updateHabit(
                  index,
                  habit.copyWith(progressValue: habit.progressValue! - 1),
                );
              }
            },
            onTimerStart: () {
              // Open Timer Popup (Next Feature)
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addHabit'),
        child: Icon(Icons.add),
      ),
    );
  }
}