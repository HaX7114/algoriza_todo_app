import 'package:algoriza_todo_app/presentation/add_task/add_task_cubit/add_task_cubit.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/my_text.dart';
import 'package:algoriza_todo_app/utils/styles/cosntants.dart';
import 'package:algoriza_todo_app/utils/styles/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class TitledColorPalette extends StatelessWidget {
  const TitledColorPalette({Key? key, required this.mainCubit})
      : super(key: key);
  final AddTaskCubit mainCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: 'Choose a color',
            size: fontSizeM - 3,
          ),
          K_vSpace10,
          MaterialColorPicker(
            onColorChange: (value) {
              mainCubit.setTaskColor(value);
            },
          ),
        ],
      ),
    );
  }
}
