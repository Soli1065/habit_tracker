import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/habit_provider.dart';

class ProgressScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Progress")),
      body: habits.isEmpty
          ? Center(child: Text("No habits to track"))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: habits.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.streak.toDouble())).toList(),
                isCurved: true,
                belowBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}