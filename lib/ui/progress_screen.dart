import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/habit_provider.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);

    int totalCompleted = habits.where((habit) => habit.isCompleted).length;
    String bestHabit = habits.isEmpty ? "None" : habits.reduce((a, b) => a.streak > b.streak ? a : b).name;
    String mostMissedHabit = habits.isEmpty ? "None" : habits.reduce((a, b) => a.streak < b.streak ? a : b).name;

    return Scaffold(
      appBar: AppBar(title: Text("Weekly Report")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text("Total Habits Completed"),
                trailing: Text("$totalCompleted"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Best Habit"),
                subtitle: Text(bestHabit),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Most Missed Habit"),
                subtitle: Text(mostMissedHabit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}