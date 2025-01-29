import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';
import 'timezone_helper.dart';




class NotificationHelper {

  static Future<void> scheduleHabitReminder(int id, String title, String body, DateTime dateTime) async {

    final timeZone = TimeZone();

    // The device's timezone.
    String timeZoneName = await timeZone.getTimeZoneName();

    // Find the 'current location'
    final location = await timeZone.getLocation(timeZoneName);

    final scheduledDate = tz.TZDateTime.from(dateTime, location);



    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'habit_channel',
        'Habit Reminders',
        importance: Importance.max,
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}