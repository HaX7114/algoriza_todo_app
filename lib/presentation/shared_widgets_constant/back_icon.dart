import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/functions/navigation_functions.dart';
import '../../utils/styles/colors.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => navigateBack(context),
      iconSize: 25.0,
      icon: const Icon(
        CupertinoIcons.back,
        color: blackColor,
      ),
    );
  }
}
