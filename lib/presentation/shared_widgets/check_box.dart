import 'package:algoriza_todo_app/services/database_api.dart';
import 'package:algoriza_todo_app/utils/functions/toaster.dart';
import 'package:algoriza_todo_app/utils/styles/colors.dart';
import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  var color;
  var borderColor;
  var borderRadius;
  var iconColor;
  final isDone;
  final taskID;

  MyCheckBox({
    Key? key,
    required this.taskID,
    required this.isDone,
    required this.color,
    required this.borderRadius,
    this.borderColor = whiteColor,
    this.iconColor = whiteColor,
  }) : super(key: key);

  @override
  State<MyCheckBox> createState() => MyCheckBoxState();
}

class MyCheckBoxState extends State<MyCheckBox> {
  var _boxHeight = 0.0;
  var _boxWidth = 0.0;
  var _iconSize = 0.0;

  void _expandBox() {
    setState(() {
      _boxHeight = 30.0;
      _boxWidth = 30.0;
      _iconSize = 20.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _expandBox();
        await DatabaseAPI.updateTask(
            widget.taskID, DatabaseAPI.updateToCompleted);
        showToastMessage('Task has been Completed !',
            color: blackColor, textColor: greenColor);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
              border: Border.all(color: widget.borderColor),
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius - 3),
            ),
            child: AnimatedContainer(
              width: _boxWidth,
              height: _boxHeight,
              duration: const Duration(milliseconds: 130),
              color: widget.isDone ? greenColor : widget.color,
              child: Icon(
                Icons.check,
                color: widget.iconColor,
                size: _iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
