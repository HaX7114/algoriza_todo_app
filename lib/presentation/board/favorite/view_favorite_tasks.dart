import 'package:algoriza_todo_app/presentation/board/favorite/view_favorite_tasks_cubit/view_favorite_tasks_cubit.dart';
import 'package:algoriza_todo_app/presentation/board/favorite/view_favorite_tasks_cubit/view_favorite_tasks_states.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/my_text.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/view_tasks_list.dart';
import 'package:algoriza_todo_app/utils/styles/cosntants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewFavoriteTasks extends StatelessWidget {
  const ViewFavoriteTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewFavoriteTasksCubit()..getAllTasks(),
      child: BlocConsumer<ViewFavoriteTasksCubit, ViewFavoriteTasksStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ViewFavoriteTasksCubit viewFavoriteTasksCubit =
              ViewFavoriteTasksCubit.get(context);
          return ConditionalBuilder(
            condition: state is ViewFavoriteTasksGotTasksState,
            builder: (context) => Column(
              children: [
                ViewTasksList(
                  listOfTasks: viewFavoriteTasksCubit.favoriteTasks,
                  isScheduleTaskPage: false,
                ),
              ],
            ),
            fallback: (context) => Center(
              child: MyText(text: 'No Favorite Tasks', size: fontSizeL),
            ),
          );
        },
      ),
    );
  }
}
