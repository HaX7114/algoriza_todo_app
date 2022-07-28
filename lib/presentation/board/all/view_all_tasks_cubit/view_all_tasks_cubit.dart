import 'package:algoriza_todo_app/services/database_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/task.dart';
import 'view_all_tasks_states.dart';

class ViewAllTasksCubit extends Cubit<ViewAllTasksStates> {
  ViewAllTasksCubit() : super(ViewAllTasksInitState());

  static ViewAllTasksCubit get(context) => BlocProvider.of(context);

  List returnedTasks = [];
  List allTasks = [];

  getAllTasks() async {
    returnedTasks = await DatabaseAPI.getAllTasks(DatabaseAPI.getAllTasksQuery);
    _setAllTasks(returnedTasks);
    if (allTasks.isNotEmpty) {
      emit(ViewAllTasksGotTasksState());
    } else {
      emit(ViewAllTasksNoTasksState());
    }
  }

  void _setAllTasks(List list) {
    allTasks.clear();
    for (var element in list) {
      allTasks.add(Task(
        id: element["ID"],
        title: element["title"],
        date: element["date"],
        startTime: element["startTime"],
        endTime: element["endTime"],
        color: Color(int.parse(element["color"])),
        taskStatus: int.parse(element["taskStatus"]),
        isFavorite: element["isFavorite"] == "true" ? true : false,
      ));
    }
  }
}
