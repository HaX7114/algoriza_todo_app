import 'package:algoriza_todo_app/presentation/shared_widgets/my_text.dart';
import 'package:algoriza_todo_app/utils/styles/colors.dart';
import 'package:algoriza_todo_app/utils/styles/spaces.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles/cosntants.dart';
import '../../shared_widgets/check_box.dart';

class ScheduleTaskContainer extends StatelessWidget {
  const ScheduleTaskContainer({
    Key? key,
    required this.taskID,
    required this.isDone,
    required this.color,
    required this.title,
    required this.time,
    required this.taskStatus,
  }) : super(key: key);
  final color;
  final TimeOfDay time;
  final taskID;
  final isDone;
  final title;
  final taskStatus;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
      child: Container(
        height: 75.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: time.format(context),
                      size: fontSizeM - 3,
                      color: whiteColor,
                    ),
                    K_vSpace10,
                    Expanded(
                      child: MyText(
                        text: title,
                        color: whiteColor,
                        size: fontSizeM - 3,
                        fontWeight: FontWeight.normal,
                        maxLinesNumber: 1,
                        showEllipsis: true,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: MyCheckBox(
                  isDone: isDone,
                  taskID: taskID,
                  borderRadius: radius,
                  color: whiteColor,
                  iconColor: greenColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
