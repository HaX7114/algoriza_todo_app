import 'package:flutter/material.dart';
import '../../utils/styles/colors.dart';

class MainProgressIndicator extends StatelessWidget {
  const MainProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: blackColor,
      strokeWidth: 5.0,
    ));
  }
}
