import 'package:flutter/material.dart';
import '../data/models/habit.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onToggle;

  HabitTile({required this.habit, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.check_circle, color: habit.isCompleted ? Colors.green : Colors.grey),
        title: Text(habit.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Streak: ${habit.streak}"),
        trailing: Switch(value: habit.isCompleted, onChanged: (val) => onToggle()),
      ),
    );
  }
}