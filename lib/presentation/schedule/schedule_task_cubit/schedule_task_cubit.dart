import 'package:algoriza_todo_app/presentation/schedule/schedule_task_cubit/schedule_task_states.dart';
import 'package:algoriza_todo_app/services/database_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/task.dart';

class ScheduleTasksCubit extends Cubit<ScheduleTasksStates> {
  ScheduleTasksCubit() : super(ScheduleTasksInitState());

  static ScheduleTasksCubit get(context) => BlocProvider.of(context);

  List returnedTasks = [];
  List scheduleTasks = [];

  DateTime selectedDay = DateTime.now();

  getAllTasks(String date) async {
    returnedTasks = await DatabaseAPI.getScheduledTasks(
        DatabaseAPI.getScheduledTasksQuery, date);
    _setScheduleTasks(returnedTasks);
    if (scheduleTasks.isNotEmpty) {
      emit(ScheduleTasksGotTasksState());
    } else {
      emit(ScheduleTasksNoTasksState());
    }
  }

  void _setScheduleTasks(List list) {
    scheduleTasks.clear();
    for (var element in list) {
      scheduleTasks.add(Task(
        id: element["ID"],
        title: element["title"],
        date: DateTime.parse(element["date"]),
        startTime: element["startTime"],
        endTime: element["endTime"],
        color: Color(int.parse(element["color"])),
        taskStatus: int.parse(element["taskStatus"]),
        isFavorite: element["isFavorite"] == "true" ? true : false,
      ));
    }
  }
}
