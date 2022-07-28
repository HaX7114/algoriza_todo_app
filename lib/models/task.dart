import 'package:algoriza_todo_app/data/task_status.dart';

class Task {
  dynamic id;
  dynamic title;
  dynamic date;
  dynamic startTime;
  dynamic endTime;
  dynamic color;
  dynamic taskStatus;
  dynamic isFavorite;

  Task({
    this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    this.taskStatus = TaskStatus.incomplete,
    this.isFavorite = false,
  });
}
