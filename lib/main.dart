import 'package:algoriza_todo_app/presentation/board/board.dart';
import 'package:algoriza_todo_app/services/database_api.dart';
import 'package:algoriza_todo_app/services/notitfactions_api.dart';
import 'package:algoriza_todo_app/utils/theme/main_theme.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Init Notifications api
  NotificationAPI.initNotificationsAPI();
  //Initialize time zone required for scheduling notifications
  tz.initializeTimeZones();
  //Initialize DB
  await DatabaseAPI.connectDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks',
      theme: mainTheme(),
      debugShowCheckedModeBanner: false,
      home: const Board(),
    );
  }
}
