import 'package:algoriza_todo_app/presentation/schedule/schedule_task_cubit/schedule_task_cubit.dart';
import 'package:algoriza_todo_app/presentation/schedule/schedule_task_cubit/schedule_task_states.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets_constant/back_icon.dart';
import 'package:algoriza_todo_app/utils/styles/colors.dart';
import 'package:algoriza_todo_app/utils/styles/spaces.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../utils/styles/cosntants.dart';
import '../shared_widgets/my_text.dart';
import '../shared_widgets/view_tasks_list.dart';
import '../shared_widgets_constant/week_date_rail.dart';

class ScheduleTasks extends StatelessWidget {
  const ScheduleTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ScheduleTasksCubit()
          ..getAllTasks(DateTime
              .now()), //Convert because we saved the date on this format in the DB
        child: BlocConsumer<ScheduleTasksCubit, ScheduleTasksStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ScheduleTasksCubit scheduleTasksCubit =
                ScheduleTasksCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                leading: const BackIconButton(),
                title: MyText(
                  text: 'Schedule',
                  size: fontSizeL + 3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 180),
                    child: ConditionalBuilder(
                      condition: state is ScheduleTasksGotTasksState,
                      builder: (context) => ViewTasksList(
                          listOfTasks: scheduleTasksCubit.scheduleTasks,
                          isScheduleTaskPage: true),
                      fallback: (context) => Center(
                          child: MyText(
                              text: 'No Tasks Today', size: fontSizeL - 2)),
                    ),
                  ),
                  Column(
                    children: [
                      K_vSpace20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: WeeklyDatePicker(
                          currentSelectedBackgroundColorByTap: blueColor,
                          selectedDay: scheduleTasksCubit.selectedDay,
                          backgroundColor: whiteColor,
                          enableWeeknumberText: false,
                          selectedBackgroundColor: greenColor,
                          weekdayTextColor: whiteColor,
                          changeDay: (value) {
                            scheduleTasksCubit.selectedDay = value;
                            scheduleTasksCubit.getAllTasks(value);
                          },
                        ),
                      ),
                      K_vSpace20,
                      Container(
                        color: blackColor.withOpacity(0.2),
                        width: double.infinity,
                        height: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                                text: DateFormat('EEEE')
                                    .format(scheduleTasksCubit.selectedDay),
                                size: fontSizeM),
                            MyText(
                              text: DateFormat.yMMMd()
                                  .format(scheduleTasksCubit.selectedDay),
                              size: fontSizeM,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
