import 'package:algoriza_todo_app/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData mainTheme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 1.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: whiteColor, // status bar color
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: whiteColor,
    ),
    scaffoldBackgroundColor: whiteColor,
    primarySwatch: Colors.green,
  );
}
