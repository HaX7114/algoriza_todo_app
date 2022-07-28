import 'package:algoriza_todo_app/presentation/shared_widgets/my_text.dart';
import 'package:algoriza_todo_app/presentation/shared_widgets/my_text_field.dart';
import 'package:algoriza_todo_app/utils/styles/cosntants.dart';
import 'package:algoriza_todo_app/utils/styles/spaces.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';

class TitledTextField extends StatelessWidget {
  final TextEditingController textController;

  const TitledTextField({
    Key? key,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: 'Title',
            size: fontSizeM - 3,
          ),
          K_vSpace10,
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 80.0,
              minHeight: 55.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: MyTextField(
                borderColor: transparentColor,
                validatorText: 'Please type a todo task !',
                textController: textController,
                hintText: 'Type a task...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
