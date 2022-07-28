import 'package:algoriza_todo_app/presentation/board/completed/view_completed_tasks_cubit/view_completed_tasks_cubit.dart';
import 'package:algoriza_todo_app/presentation/board/completed/view_completed_tasks_cubit/view_completed_tasks_states.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/my_text.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/view_tasks_list.dart';
import 'package:algoriza_todo_app/utils/styles/cosntants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewCompletedTasks extends StatelessWidget {
  const ViewCompletedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewCompletedTasksCubit()..getAllTasks(),
      child: BlocConsumer<ViewCompletedTasksCubit, ViewCompletedTasksStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ViewCompletedTasksCubit viewCompletedTasksCubit =
              ViewCompletedTasksCubit.get(context);
          return ConditionalBuilder(
            condition: state is ViewCompletedTasksGotTasksState,
            builder: (context) => Column(
              children: [
                ViewTasksList(
                  listOfTasks: viewCompletedTasksCubit.completedTasks,
                  isScheduleTaskPage: false,
                ),
              ],
            ),
            fallback: (context) => Center(
              child: MyText(text: 'No Completed Tasks', size: fontSizeL),
            ),
          );
        },
      ),
    );
  }
}
