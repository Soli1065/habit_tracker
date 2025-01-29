import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  ref.read(habitProvider.notifier).addHabit(
                    Habit(name: _controller.text, createdAt: DateTime.now()),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text('Add Habit'),
            ),
          ],
        ),
      ),
    );
  }
}