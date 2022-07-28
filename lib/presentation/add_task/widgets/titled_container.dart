import 'package:algoriza_todo_app/presentation/shared_widgets/my_text.dart';
import 'package:algoriza_todo_app/utils/styles/cosntants.dart';
import 'package:algoriza_todo_app/utils/styles/spaces.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';

class TitledContainer extends StatelessWidget {
  final title;
  var content;
  final suffixIcon;
  TitledContainer(
      {Key? key,
      required this.title,
      required this.content,
      required this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: title,
            size: fontSizeM - 3,
          ),
          K_vSpace10,
          Container(
            height: 55.0,
            decoration: BoxDecoration(
              color: greyColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: content,
                    size: fontSizeM - 3,
                    color: blackColor.withOpacity(0.3),
                    fontWeight: FontWeight.normal,
                  ),
                  Icon(suffixIcon,
                      color: blackColor.withOpacity(0.3), size: 20.0)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
