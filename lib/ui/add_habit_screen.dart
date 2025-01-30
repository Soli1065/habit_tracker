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

    List<bool> selectedDays = List.filled(7, false);



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

            SizedBox(height: 10),

            StatefulBuilder(
              builder: (context, setState){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(7, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDays[index] = !selectedDays[index];
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: selectedDays[index] ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(["S", "M", "T", "W", "T", "F", "S"][index]),
                      ),
                    );
                  }),
                );
              },
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  List<int> repeatDays = [];
                  for (int i = 0; i < selectedDays.length; i++) {
                    if (selectedDays[i]) repeatDays.add(i);
                  }
                  final habit = Habit(name: controller.text, createdAt: DateTime.now(), category: selectedCategory, repeatDays: repeatDays);
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