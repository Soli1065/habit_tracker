import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/data/database/habit_db.dart';
import 'package:habit_tracker/ui/main_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'core/theme.dart';
import 'ui/add_habit_screen.dart';
import 'ui/home_screen.dart';
import 'ui/progress_screen.dart';
import 'ui/settings_screen.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Hive
  await Hive.initFlutter();
  await HabitDB.init();

  /// Initialize timezones
  tz.initializeTimeZones();


  /// Local Notification
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);


  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child){
        final isDarkMode = ref.watch(darkModeProvider);
        return MaterialApp(
          title: 'Habit Tracker',
          debugShowCheckedModeBanner: false,
          theme: isDarkMode ? darkTheme : lightTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => const MainScreen(),
            '/home': (context) => HomeScreen(),
            '/progress': (context) => ProgressScreen(),
            '/settings': (context) => SettingsScreen(),
            '/addHabit': (context) => AddHabitScreen(),
          },
        );
      },
    );
  }
}