import 'package:algoriza_todo_app/services/database_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/task.dart';
import 'view_completed_tasks_states.dart';

class ViewCompletedTasksCubit extends Cubit<ViewCompletedTasksStates> {
  ViewCompletedTasksCubit() : super(ViewCompletedTasksInitState());

  static ViewCompletedTasksCubit get(context) => BlocProvider.of(context);

  List returnedTasks = [];
  List completedTasks = [];

  getAllTasks() async {
    returnedTasks =
        await DatabaseAPI.getAllTasks(DatabaseAPI.getCompletedTasksQuery);
    _setCompletedTasks(returnedTasks);
    if (completedTasks.isNotEmpty) {
      emit(ViewCompletedTasksGotTasksState());
    } else {
      emit(ViewCompletedTasksNoTasksState());
    }
  }

  void _setCompletedTasks(List list) {
    completedTasks.clear();
    for (var element in list) {
      completedTasks.add(Task(
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
