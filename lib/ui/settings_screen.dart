import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeProvider = StateProvider<bool>((ref) => false);

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListTile(
        title: Text("Dark Mode"),
        trailing: Switch(
          value: isDarkMode,
          onChanged: (val) => ref.read(darkModeProvider.notifier).state = val,
        ),
      ),
    );
  }
}