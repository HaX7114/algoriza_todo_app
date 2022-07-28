import 'package:algoriza_todo_app/presentation/shared_widgets/my_text.dart';
import 'package:algoriza_todo_app/utils/styles/cosntants.dart';
import 'package:algoriza_todo_app/utils/styles/spaces.dart';
import 'package:flutter/material.dart';

import '../../shared_widgets/check_box.dart';

class BoardTaskContainer extends StatelessWidget {
  final color;
  final taskID;
  var isDone;
  final String text;
  BoardTaskContainer({
    Key? key,
    required this.taskID,
    required this.color,
    required this.isDone,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyCheckBox(
          isDone: isDone,
          color: color,
          borderRadius: 10.0,
          borderColor: color,
          taskID: taskID,
        ),
        K_hSpace10,
        K_hSpace10,
        Expanded(
            child: MyText(
          text: text,
          maxLinesNumber: 2,
          showEllipsis: true,
          size: fontSizeM,
        )),
      ],
    );
  }
}
