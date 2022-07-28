import 'package:algoriza_todo_app/services/database_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/task.dart';
import 'view_uncompleted_tasks_states.dart';

class ViewUncompletedTasksCubit extends Cubit<ViewUncompletedTasksStates> {
  ViewUncompletedTasksCubit() : super(ViewUncompletedTasksInitState());

  static ViewUncompletedTasksCubit get(context) => BlocProvider.of(context);

  List returnedTasks = [];
  List uncompletedTasks = [];

  getAllTasks() async {
    returnedTasks =
        await DatabaseAPI.getAllTasks(DatabaseAPI.getUncompletedTasksQuery);
    _setUncompletedTasks(returnedTasks);
    if (uncompletedTasks.isNotEmpty) {
      emit(ViewUncompletedTasksGotTasksState());
    } else {
      emit(ViewUncompletedTasksNoTasksState());
    }
  }

  void _setUncompletedTasks(List list) {
    uncompletedTasks.clear();
    for (var element in list) {
      uncompletedTasks.add(Task(
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
