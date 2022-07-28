import 'package:algoriza_todo_app/data/repeaters_consts.dart';
import 'package:algoriza_todo_app/presentation/add_task/add_task_cubit/add_task_cubit.dart';
import 'package:algoriza_todo_app/services/notitfactions_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../../utils/styles/cosntants.dart';
import '../../shared_widgets/my_text.dart';

void showRepeatModalSheet(context, AddTaskCubit addTaskCubit) {
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
                    addTaskCubit.changeRepeat(NotificationAPI.repeatDaily,
                        RepeatersConstants.repeatDaily);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: RepeatersConstants.repeatDaily,
                        size: fontSizeM,
                        color: greenColor,
                      ),
                      const Icon(
                        CupertinoIcons.repeat,
                        color: blackColor,
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    addTaskCubit.changeRepeat(NotificationAPI.repeatWeekly,
                        RepeatersConstants.repeatWeekly);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: RepeatersConstants.repeatWeekly,
                        size: fontSizeM,
                        color: greenColor,
                      ),
                      const Icon(
                        CupertinoIcons.repeat,
                        color: blackColor,
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    addTaskCubit.changeRepeat(NotificationAPI.repeatMonthly,
                        RepeatersConstants.repeatMonthly);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: RepeatersConstants.repeatMonthly,
                        size: fontSizeM,
                        color: greenColor,
                      ),
                      const Icon(
                        CupertinoIcons.repeat,
                        color: blackColor,
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    addTaskCubit.changeRepeat(NotificationAPI.doNotRepeat,
                        RepeatersConstants.doNotRepeat);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: RepeatersConstants.doNotRepeat,
                        size: fontSizeM,
                        color: Colors.red,
                      ),
                      const Icon(
                        Icons.motion_photos_off,
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
