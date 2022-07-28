import 'package:algoriza_todo_app/presentation/board/all/view_all_tasks_cubit/view_all_tasks_cubit.dart';
import 'package:algoriza_todo_app/presentation/board/all/view_all_tasks_cubit/view_all_tasks_states.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/my_text.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/view_tasks_list.dart';
import 'package:algoriza_todo_app/utils/styles/cosntants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAllTasks extends StatelessWidget {
  const ViewAllTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewAllTasksCubit()..getAllTasks(),
      child: BlocConsumer<ViewAllTasksCubit, ViewAllTasksStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ViewAllTasksCubit viewAllTasksCubit = ViewAllTasksCubit.get(context);
          return ConditionalBuilder(
            condition: state is ViewAllTasksGotTasksState,
            builder: (context) => Column(
              children: [
                ViewTasksList(
                  listOfTasks: viewAllTasksCubit.allTasks,
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
