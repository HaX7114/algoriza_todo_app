import 'package:algoriza_todo_app/data/reminders_consts.dart';
import 'package:algoriza_todo_app/presentation/add_task/add_task_cubit/add_task_cubit.dart';
import 'package:algoriza_todo_app/services/notitfactions_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../../utils/styles/cosntants.dart';
import '../../shared_widgets/my_text.dart';

void showReminderModalSheet(context, AddTaskCubit addTaskCubit) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius),
        topLeft: Radius.circular(radius),
      ),
    ),
    context: context,
    builder: (context) {
      return SizedBox(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    addTaskCubit.changeReminder(
                        NotificationAPI.reminderOneDayBefore,
                        RemindersConstants.remindOneDay);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: RemindersConstants.remindOneDay,
                        size: fontSizeM,
                        color: greenColor,
                      ),
                      const Icon(
                        CupertinoIcons.alarm,
                        color: blackColor,
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    addTaskCubit.changeReminder(
                        NotificationAPI.reminderOneHourBefore,
                        RemindersConstants.remindOneHour);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: RemindersConstants.remindOneHour,
                        size: fontSizeM,
                        color: greenColor,
                      ),
                      const Icon(
                        CupertinoIcons.alarm,
                        color: blackColor,
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    addTaskCubit.changeReminder(
                        NotificationAPI.reminderThirtyMinBefore,
                        RemindersConstants.remindThirtyMinutes);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: RemindersConstants.remindThirtyMinutes,
                        size: fontSizeM,
                        color: greenColor,
                      ),
                      const Icon(
                        CupertinoIcons.alarm,
                        color: blackColor,
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    addTaskCubit.changeReminder(
                        NotificationAPI.reminderTenMinBefore,
                        RemindersConstants.remindTenMinutes);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: RemindersConstants.remindTenMinutes,
                        size: fontSizeM,
                        color: greenColor,
                      ),
                      const Icon(
                        CupertinoIcons.alarm,
                        color: blackColor,
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    addTaskCubit.changeReminder(NotificationAPI.doNotRemindMe,
                        RemindersConstants.doNotRemindMe);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: RemindersConstants.doNotRemindMe,
                        size: fontSizeM,
                        color: Colors.red,
                      ),
                      const Icon(
                        Icons.alarm_off_rounded,
                        color: blackColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
