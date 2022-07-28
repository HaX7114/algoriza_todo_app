import 'package:algoriza_todo_app/presentation/board/uncompleted/view_uncompleted_tasks_cubit/view_uncompleted_tasks_cubit.dart';
import 'package:algoriza_todo_app/presentation/board/uncompleted/view_uncompleted_tasks_cubit/view_uncompleted_tasks_states.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/my_text.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/view_tasks_list.dart';
import 'package:algoriza_todo_app/utils/styles/cosntants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewUncompletedTasks extends StatelessWidget {
  const ViewUncompletedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewUncompletedTasksCubit()..getAllTasks(),
      child:
          BlocConsumer<ViewUncompletedTasksCubit, ViewUncompletedTasksStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ViewUncompletedTasksCubit viewUncompletedTasksCubit =
              ViewUncompletedTasksCubit.get(context);
          return ConditionalBuilder(
            condition: state is ViewUncompletedTasksGotTasksState,
            builder: (context) => Column(
              children: [
                ViewTasksList(
                  listOfTasks: viewUncompletedTasksCubit.uncompletedTasks,
                  isScheduleTaskPage: false,
                ),
              ],
            ),
            fallback: (context) => Center(
              child: MyText(text: 'No Tasks Available', size: fontSizeL),
            ),
          );
        },
      ),
    );
  }
}
