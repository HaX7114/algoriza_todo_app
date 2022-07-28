import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;

class NotificationAPI {
  //Reminders
  static const bool doNotRemindMe = false;
  static const bool remindMe = true;

  static const int reminderOneDayBefore = 1;
  static const int reminderOneHourBefore = 60;
  static const int reminderThirtyMinBefore = 30;
  static const int reminderTenMinBefore = 10;
  static const int reminderOneMinBefore = 2;

  //Repeaters
  static const doNotRepeat = null;
  static const repeatDaily = DateTimeComponents.time;
  static const repeatWeekly = DateTimeComponents.dayOfWeekAndTime;
  static const repeatMonthly = DateTimeComponents.dayOfMonthAndTime;

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initNotificationsAPI() async {
    //Android settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //IOS Settings
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    //Mac OS Settings
    const MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();

    //Init Settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
    });

    debugPrint('Notitfications API Initialized');
  }

  static void setNotificationSchedule({
    required int hour,
    required int min,
    required int notificationIndex,
    required int reminderChoice,
    required DateTimeComponents repeating,
    required String content,
    required bool setReminder,
  }) {
    if (setReminder) {
      _scheduleWithTime(
          hour: hour,
          min: min,
          notificationIndex: notificationIndex,
          repeating: repeating,
          content: content,
          reminderChoice: reminderChoice);
    }
  }

  static Future<void> _scheduleWithTime({
    required int hour,
    required int min,
    required int notificationIndex,
    required int reminderChoice,
    required DateTimeComponents repeating,
    required String content,
  }) async {
    await _flutterLocalNotificationsPlugin
        .zonedSchedule(
          notificationIndex, //ID
          "Reminder", //TITLE
          content, //CONTENT
          _determineTime(hour, min, reminderChoice), //SCHEDULE TIME
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description',
              importance: Importance.max,
              priority: Priority.max,
            ),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents:
              repeating, //--------------repeat it daily , weekly ,..
        )
        .then(
          (value) => debugPrint('Notification has been set at $hour + $min'),
        );
  }

  static tz.TZDateTime _determineTime(int hour, int min, int reminderChoice) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, min);
    debugPrint('Notification' + scheduledDate.toString());
    //Subtract because we want to remind

    scheduledDate = scheduledDate.subtract(_determineDuration(reminderChoice));

    debugPrint('Notification' + scheduledDate.toString());
    return scheduledDate;
  }

  static Duration _determineDuration(
    int reminderChoice,
  ) {
    if (reminderChoice == reminderOneDayBefore) {
      return const Duration(days: 1);
    } else if (reminderChoice == reminderOneHourBefore) {
      return const Duration(hours: 1);
    } else if (reminderChoice == reminderThirtyMinBefore) {
      return const Duration(minutes: 30);
    } else if (reminderChoice == reminderTenMinBefore) {
      return const Duration(minutes: 10);
    } else {
      return const Duration(minutes: 1);
    }
  }

  static Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
