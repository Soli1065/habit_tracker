import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/habit_provider.dart';
import '../data/models/habit.dart';

class HabitCalendarScreen extends ConsumerStatefulWidget {
  const HabitCalendarScreen({super.key});

  @override
  _HabitCalendarScreenState createState() => _HabitCalendarScreenState();
}

class _HabitCalendarScreenState extends ConsumerState<HabitCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final habits = ref.watch(habitProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Habit Calendar")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: _selectedDay == null
                ? Center(child: Text("Select a day to view habits"))
                : ListView(
              children: habits
                  .where((habit) => habit.createdAt.day == _selectedDay!.day)
                  .map((habit) => ListTile(
                title: Text(habit.name),
                subtitle: Text(habit.category),
                trailing: habit.isCompleted
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(Icons.close, color: Colors.red),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}