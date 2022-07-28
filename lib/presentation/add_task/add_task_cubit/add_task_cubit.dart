import 'package:algoriza_todo_app/data/reminders_consts.dart';
import 'package:algoriza_todo_app/models/task.dart';
import 'package:algoriza_todo_app/services/database_api.dart';
import 'package:algoriza_todo_app/services/notitfactions_api.dart';
import 'package:algoriza_todo_app/utils/functions/toaster.dart';
import 'package:algoriza_todo_app/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import '../../../data/repeaters_consts.dart';
import '../widgets/reminder_modal_bottom_sheet.dart';
import '../widgets/repeat_modal_bottom_sheet.dart';
import 'add_task_states.dart';

class AddTaskCubit extends Cubit<AddTaskStates> {
  AddTaskCubit() : super(AddTaskInitState());

  static AddTaskCubit get(context) => BlocProvider.of(context);

  DateTime initDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  Color taskColor = materialColors[0]; //default color
  late TimeOfDay endTime =
      endTime = TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
  final textController = TextEditingController();

  //Reminders
  var reminderCurrentTextValue = RemindersConstants.doNotRemindMe;
  dynamic setReminder = NotificationAPI.doNotRemindMe;
  //Repeaters
  var repeatCurrentTextValue = RepeatersConstants.doNotRepeat;
  dynamic setRepeat = NotificationAPI.doNotRepeat;

  void setDate(context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: initDate,
      lastDate: initDate.add(
        const Duration(days: 365),
      ),
    ).then(
      (value) {
        selectedDate = value!;
        resetTimesWhenDateChanged();
        emit(AddTaskChangedDateState());
      },
    );
  }

  void setStartTime(context) {
    showTimePicker(
      context: context,
      initialTime: startTime,
    ).then((value) {
      startTime = value!;
      if (startTime.hour < TimeOfDay.now().hour &&
              selectedDate.day == initDate.day ||
          startTime.minute < TimeOfDay.now().minute &&
              startTime.hour == TimeOfDay.now().hour &&
              selectedDate.day == initDate.day) {
        startTime = TimeOfDay.now();
        emit(AddTaskChangedStartTimeErrorState());
      } else {
        emit(AddTaskChangedStartTimeState());
      }
    });
  }

  void setEndTime(context) {
    showTimePicker(
      context: context,
      initialTime: endTime,
    ).then(
      (value) {
        endTime = value!;
        if (endTime.hour <= startTime.hour ||
            endTime.minute <= startTime.minute &&
                endTime.hour <= startTime.hour) {
          endTime =
              TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
          emit(AddTaskChangedEndTimeErrorState());
        } else {
          emit(AddTaskChangedEndTimeState());
        }
      },
    );
  }

  void setTaskReminder(context, cubit) {
    showReminderModalSheet(context, cubit);
  }

  void changeReminder(newReminder, newReminderCurrentText) {
    setReminder = newReminder;
    reminderCurrentTextValue = newReminderCurrentText;
    //We do the next operation to make sure that the repeat will depend on the reminder choice
    repeatCurrentTextValue = RepeatersConstants.doNotRepeat;
    emit(AddTaskChangeReminderState());
  }

  void setTaskRepeat(context, cubit) {
    showRepeatModalSheet(context, cubit);
  }

  void changeRepeat(newRepeat, newRepeatCurrentText) {
    setRepeat = newRepeat;
    repeatCurrentTextValue = newRepeatCurrentText;
    emit(AddTaskChangeRepeatState());
  }

  void resetTimesWhenDateChanged() {
    startTime = TimeOfDay.now();
    endTime = TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
  }

  void setTaskColor(selectedColor) {
    taskColor = selectedColor;
  }

  Future<int> setToDataBase() async {
    late int taskID;
    Task task = Task(
      title: textController.text,
      date: selectedDate,
      startTime: startTime,
      endTime: endTime,
      color: taskColor,
    );
    debugPrint("TITLE : ${textController.text}\n"
        "DATE : $selectedDate\n"
        "START TIME : $startTime\n"
        "END TIME : $endTime\n"
        "COLOR : ${taskColor.value.toString()}\n"
        "");

    taskID = await DatabaseAPI.insertIntoTableTasks(task);
    showToastMessage("Task added Successfully!",
        textColor: greenColor, color: blackColor);
    return taskID;
  }
}
