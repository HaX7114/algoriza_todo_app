import 'package:algoriza_todo_app/services/database_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/task.dart';
import 'view_favorite_tasks_states.dart';

class ViewFavoriteTasksCubit extends Cubit<ViewFavoriteTasksStates> {
  ViewFavoriteTasksCubit() : super(ViewFavoriteTasksInitState());

  static ViewFavoriteTasksCubit get(context) => BlocProvider.of(context);

  List returnedTasks = [];
  List favoriteTasks = [];

  getAllTasks() async {
    returnedTasks =
        await DatabaseAPI.getAllTasks(DatabaseAPI.getFavoriteTasksQuery);
    _setFavoriteTasks(returnedTasks);
    if (favoriteTasks.isNotEmpty) {
      emit(ViewFavoriteTasksGotTasksState());
    } else {
      emit(ViewFavoriteTasksNoTasksState());
    }
  }

  void _setFavoriteTasks(List list) {
    favoriteTasks.clear();
    for (var element in list) {
      favoriteTasks.add(Task(
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
