import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/notification_helper.dart';
import '../logic/habit_provider.dart';
import '../data/models/habit.dart';

class AddHabitScreen extends ConsumerWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Habit')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Habit Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_controller.text.isNotEmpty) {
                  final habit = Habit(name: _controller.text, createdAt: DateTime.now());
                  ref.read(habitProvider.notifier).addHabit(habit);

                  await NotificationHelper.scheduleHabitReminder(
                    habit.hashCode,
                    "Reminder: ${habit.name}",
                    "Don't forget to complete your habit today!",

                    //TODO modify the time and fix its schedule
                    DateTime.now(),
                  );

                  Navigator.pop(context);
                }
              },
              child: const Text('Add Habit'),
            ),          ],
        ),
      ),
    );
  }
}