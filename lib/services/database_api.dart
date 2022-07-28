import 'package:algoriza_todo_app/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../data/database_consts.dart';

class DatabaseAPI {
  static late Database _database;

  //Select FROM DB
  static const String getAllTasksQuery = "SELECT * FROM $tableTasks";
  static const String getCompletedTasksQuery =
      "SELECT * FROM $tableTasks WHERE $taskStatus = '1' ";
  static const String getUncompletedTasksQuery =
      "SELECT * FROM $tableTasks WHERE $taskStatus = '2' ";
  static const String getFavoriteTasksQuery =
      "SELECT * FROM $tableTasks WHERE $isFavorite = 'true' ";

  //SELECT FROM WHERE
  static const String getScheduledTasksQuery =
      "SELECT * FROM $tableTasks WHERE $date = ";
  //Update in DB
  static const String updateToCompleted =
      'UPDATE $tableTasks SET $taskStatus = "1" WHERE ';
  static const String updateToFavorite =
      'UPDATE $tableTasks SET $isFavorite = "true" WHERE ';

  static const String updateRemoveFromFavorite =
      'UPDATE $tableTasks SET $isFavorite = "false" WHERE ';

  static Future<void> connectDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    // open the database
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db
            .execute(
          'CREATE TABLE $tableTasks (ID INTEGER PRIMARY KEY, $title TEXT, $date TEXT, $startTime TEXT, $endTime TEXT, $color TEXT, $taskStatus TEXT, $isFavorite TEXT)',
        )
            .then((value) {
          debugPrint('TABLE CREATED !');
        });
      },
      onOpen: (db) {
        debugPrint('DB OPENED !');
      },
    );
  }

  static Future<int> insertIntoTableTasks(Task task) async {
    late int id;
    await _database.transaction((txn) async {
      id = await txn.rawInsert(
        'INSERT INTO $tableTasks ($title,$date,$startTime,$endTime,$color,$taskStatus,$isFavorite) VALUES("${task.title}", "${DateFormat.yMMMd().format(task.date)}", "${task.startTime.toString()}","${task.endTime.toString()}","${task.color.value.toString()}","${task.taskStatus.toString()}","${task.isFavorite.toString()}")',
      );
      debugPrint('inserted: $id');
    });
    return id;
  }

  static Future<List> getAllTasks(String query) async {
    List listOfTasks;
    listOfTasks = await _database.rawQuery(query);
    return listOfTasks;
  }

  static Future<List> getScheduledTasks(String query, String date) async {
    String queryDate = "\"" + date + "\"";
    List listOfTasks;
    listOfTasks = await _database.rawQuery(query + queryDate);
    debugPrint('DONE SELECT FROM WHERE ');
    return listOfTasks;
  }

  static updateTask(id, String query) async {
    await _database
        .rawUpdate(query + 'ID = $id')
        .then((value) => debugPrint('UPDATED !'));
  }

  static deleteTask(id) async {
    await _database.rawDelete('DELETE FROM $tableTasks WHERE ID = $id');
  }
}
