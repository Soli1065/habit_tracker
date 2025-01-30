import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/habit_provider.dart';
import '../data/models/habit.dart';
import '../widgets/habit_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

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
                Habit(
                  name: habit.name,
                  isCompleted: !habit.isCompleted,
                  createdAt: habit.createdAt,
                  streak: !habit.isCompleted ? habit.streak + 1 : 0,
                  category: habit.category
                ),
              );
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