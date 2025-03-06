import 'package:flutter/material.dart';
import '../data/models/habit.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onToggle;
  final VoidCallback? onTimerStart;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const HabitTile({super.key, 
    required this.habit,
    required this.onToggle,
    this.onTimerStart,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            // Icon based on habit completion status
            Icon(
              habit.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: habit.isCompleted ? Colors.green : Colors.grey,
              size: 28,
            ),
            SizedBox(width: 12),

            // Habit Name & Category
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Streak: ${habit.streak} | Category: ${habit.category}"),
                  SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: habit.xp / 100, // Show XP progress
                    backgroundColor: Colors.grey[300],
                    color: Colors.blueAccent,
                  ),
                  Text("XP: ${habit.xp} / 100 | Level: ${habit.level}", style: TextStyle(fontSize: 12)),
                ],
              ),
            ),

            // Dynamic Action Based on Habit Type
            if (habit.habitType == "Checkbox") _buildCheckbox(),
            if (habit.habitType == "Numeric") _buildNumericTracker(),
            if (habit.habitType == "Timer") _buildTimerButton(),
          ],
        ),
      ),
    );
  }

  // Checkbox UI for basic habits
  Widget _buildCheckbox() {
    return Switch(
      value: habit.isCompleted,
      onChanged: (_) => onToggle(),
      activeColor: Colors.green,
    );
  }

  // Numeric Habit UI (+/- Buttons for habit progress)
  Widget _buildNumericTracker() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove_circle, color: Colors.redAccent),
          onPressed: onDecrement,
        ),
        Text(
          "${habit.progressValue ?? 0} / ${habit.goalValue ?? 1}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.add_circle, color: Colors.greenAccent),
          onPressed: onIncrement,
        ),
      ],
    );
  }

  // Timer Button for Timer-Based Habits
  Widget _buildTimerButton() {
    return ElevatedButton(
      onPressed: onTimerStart,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text("Start", style: TextStyle(color: Colors.white)),
    );
  }
}