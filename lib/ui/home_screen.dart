import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/habit_provider.dart';
import '../data/models/habit.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Habit Tracker')),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits[index];
          return ListTile(
            title: Text(habit.name),
            subtitle: Text("Streak: ${habit.streak}"),
            trailing: Checkbox(
              value: habit.isCompleted,
              onChanged: (val) {
                ref.read(habitProvider.notifier).updateHabit(
                  index,
                  Habit(
                    name: habit.name,
                    isCompleted: val ?? false,
                    createdAt: habit.createdAt,
                    streak: val == true ? habit.streak + 1 : 0,
                  ),
                );
              },
            ),
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