import 'package:algoriza_todo_app/presentation/add_task/add_task_cubit/add_task_cubit.dart';
import 'package:algoriza_todo_app/presentation/add_task/add_task_cubit/add_task_states.dart';
import 'package:algoriza_todo_app/presentation/add_task/widgets/titled_color_palette.dart';
import 'package:algoriza_todo_app/presentation/add_task/widgets/titled_container.dart';
import 'package:algoriza_todo_app/presentation/add_task/widgets/titled_text_field.dart';
import 'package:algoriza_todo_app/utils/functions/toaster.dart';
import 'package:algoriza_todo_app/utils/styles/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../data/reminders_consts.dart';
import '../../utils/styles/cosntants.dart';
import '../shared_widgets/bottom_button.dart';
import '../shared_widgets/my_text.dart';
import '../shared_widgets_constant/back_icon.dart';

class AddTask extends StatelessWidget {
  AddTask({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskCubit(),
      child: BlocConsumer<AddTaskCubit, AddTaskStates>(
        listener: (context, state) {
          if (state is AddTaskChangedEndTimeErrorState) {
            showToastMessage(
              "The end time can't be before or equal to the start time !",
              color: Colors.redAccent,
            );
          }
          if (state is AddTaskChangedStartTimeErrorState) {
            showToastMessage(
              "The start time can't be before the time of now !",
              color: Colors.redAccent,
            );
          }
        },
        builder: (context, state) {
          AddTaskCubit addTaskCubit = AddTaskCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: const BackIconButton(),
              title: MyText(
                text: 'Add task',
                size: fontSizeL + 3,
                fontWeight: FontWeight.w600,
              ),
            ),
            body: Form(
              key: _formKey,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitledTextField(
                              textController: addTaskCubit.textController),
                          GestureDetector(
                            onTap: () {
                              addTaskCubit.setDate(context);
                            },
                            child: TitledContainer(
                              title: 'Date',
                              content: DateFormat.yMMMd()
                                  .format(addTaskCubit.selectedDate),
                              suffixIcon: CupertinoIcons.chevron_down,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    addTaskCubit.setStartTime(context);
                                  },
                                  child: TitledContainer(
                                    title: 'Start time',
                                    content:
                                        addTaskCubit.startTime.format(context),
                                    suffixIcon: CupertinoIcons.clock,
                                  ),
                                ),
                              ),
                              K_hSpace20,
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    addTaskCubit.setEndTime(context);
                                  },
                                  child: TitledContainer(
                                    title: 'End time',
                                    content:
                                        addTaskCubit.endTime.format(context),
                                    suffixIcon: CupertinoIcons.clock,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              addTaskCubit.setTaskReminder(
                                  context, addTaskCubit);
                            },
                            child: TitledContainer(
                              title: 'Set reminder',
                              content: addTaskCubit.reminderCurrentTextValue,
                              suffixIcon: CupertinoIcons.chevron_down,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (addTaskCubit.reminderCurrentTextValue ==
                                  RemindersConstants.doNotRemindMe) {
                                showToastMessage(
                                  'You must set a reminder first !',
                                );
                              } else {
                                addTaskCubit.setTaskRepeat(
                                    context, addTaskCubit);
                              }
                            },
                            child: TitledContainer(
                              title: 'Repeat',
                              content: addTaskCubit.repeatCurrentTextValue,
                              suffixIcon: CupertinoIcons.chevron_down,
                            ),
                          ),
                          TitledColorPalette(mainCubit: addTaskCubit),
                          K_vSpace20,
                          K_vSpace20,
                          K_vSpace20,
                          K_vSpace20,
                        ],
                      ),
                    ),
                  ),
                  ButtomButton(
                    buttonText: 'Create a task',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addTaskCubit.setToDataBase();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
