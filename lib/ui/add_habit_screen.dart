import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/notification_helper.dart';
import '../logic/habit_provider.dart';
import '../data/models/habit.dart';

class AddHabitScreen extends ConsumerWidget {
  const AddHabitScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    final List<String> categories = ["Health", "Productivity", "Learning", "Fitness", "Mindfulness"];
    String selectedCategory = "Health";


    return Scaffold(
      appBar: AppBar(title: Text('Add Habit')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Habit Name'),
            ),
            SizedBox(height: 10),

            StatefulBuilder(
              builder: (context, setState){
                return DropdownButton<String>(
                  value: selectedCategory,
                  items: categories.map((category) {
                    return DropdownMenuItem(value: category, child: Text(category));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                );
              },
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  final habit = Habit(name: controller.text, createdAt: DateTime.now(), category: selectedCategory);
                  ref.read(habitProvider.notifier).addHabit(habit);

                  await NotificationHelper.scheduleHabitReminder(
                    habit.hashCode,
                    "Reminder: ${habit.name}",
                    "Don't forget to complete your habit today!",

                    8,0,
                  );

                  if(context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Add Habit'),
            ),
          ],
        ),
      ),
    );
  }
}