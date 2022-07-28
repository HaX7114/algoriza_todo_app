import 'package:algoriza_todo_app/presentation/schedule/schedule_tasks.dart';
import 'package:algoriza_todo_app/utils/functions/navigation_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';

class ActionsIcons extends StatelessWidget {
  const ActionsIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(CupertinoIcons.search, color: blackColor),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(CupertinoIcons.bell, color: blackColor),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(CupertinoIcons.calendar, color: blackColor),
          onPressed: () {
            navigateTo(context, const ScheduleTasks());
          },
        ),
      ],
    );
  }
}
