import 'package:algoriza_todo_app/presentation/schedule/widgets/schedule_task_design.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/my_text.dart';
import 'package:algoriza_todo_app/services/database_api.dart';
import 'package:algoriza_todo_app/services/notitfactions_api.dart';
import 'package:algoriza_todo_app/utils/functions/toaster.dart';
import 'package:algoriza_todo_app/utils/styles/colors.dart';
import 'package:algoriza_todo_app/utils/styles/cosntants.dart';
import 'package:algoriza_todo_app/utils/styles/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../board/widgets/board_task_design.dart';

class ViewTasksList extends StatelessWidget {
  final List listOfTasks;
  final isScheduleTaskPage;

  const ViewTasksList({
    Key? key,
    required this.listOfTasks,
    required this.isScheduleTaskPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _topPadding = 16.0;
    double _rightPadding = 16.0;
    double _leftPadding = 16.0;
    double _bottomPadding = 16.0;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (isScheduleTaskPage) {
                return InkWell(
                  onTap: () {},
                  child: ScheduleTaskContainer(
                    isDone: listOfTasks[index].taskStatus == 1 ? true : false,
                    taskID: listOfTasks[index].id,
                    title: listOfTasks[index].title,
                    color: listOfTasks[index].color,
                    taskStatus: listOfTasks[index].taskStatus,
                    time: listOfTasks[index].startTime,
                  ),
                );
              } else {
                return Dismissible(
                  key: ValueKey(index),
                  background: LeftDismissableContainer(
                    isFavorite: listOfTasks[index].isFavorite,
                  ),
                  secondaryBackground: const RightDismissableContainer(),
                  onDismissed: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      //favorite
                      if (!listOfTasks[index].isFavorite) {
                        await DatabaseAPI.updateTask(listOfTasks[index].id,
                            DatabaseAPI.updateToFavorite);
                        showToastMessage("Task added to Favorites !",
                            color: blueColor, textColor: whiteColor);
                      } else {
                        await DatabaseAPI.updateTask(listOfTasks[index].id,
                            DatabaseAPI.updateRemoveFromFavorite);
                        showToastMessage("Task removed from Favorites !",
                            color: blueColor, textColor: whiteColor);
                      }
                    } else {
                      await DatabaseAPI.deleteTask(listOfTasks[index].id);
                      await NotificationAPI.cancelNotification(
                          listOfTasks[index].id);
                      showToastMessage("Task Deleted !",
                          color: Colors.red, textColor: whiteColor);
                    }
                  },
                  direction: DismissDirection.horizontal,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: index != 0 ? _topPadding : _topPadding * 2,
                        right: _rightPadding,
                        left: _leftPadding,
                        bottom: index != listOfTasks.length - 1
                            ? _bottomPadding
                            : _bottomPadding * 6,
                      ),
                      child: BoardTaskContainer(
                        taskID: listOfTasks[index].id,
                        text: listOfTasks[index].title,
                        color: listOfTasks[index].color,
                        isDone:
                            listOfTasks[index].taskStatus == 1 ? true : false,
                      ),
                    ),
                  ),
                );
              }
            },
            itemCount: listOfTasks.length,
          )
        ],
      ),
    );
  }
}

class LeftDismissableContainer extends StatelessWidget {
  const LeftDismissableContainer({Key? key, required this.isFavorite})
      : super(key: key);
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    debugPrint(isFavorite.toString());
    return Container(
      color: blueColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              children: [
                Icon(isFavorite ? Icons.cancel : CupertinoIcons.heart,
                    color: whiteColor),
                K_vSpace10,
                MyText(
                  text: isFavorite ? 'Unfavorite' : 'Favorite task',
                  size: fontSizeM - 3,
                  fontWeight: FontWeight.normal,
                  color: whiteColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RightDismissableContainer extends StatelessWidget {
  const RightDismissableContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                const Icon(CupertinoIcons.delete, color: whiteColor),
                K_vSpace10,
                MyText(
                  text: 'Delete task',
                  size: fontSizeM - 3,
                  fontWeight: FontWeight.normal,
                  color: whiteColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
