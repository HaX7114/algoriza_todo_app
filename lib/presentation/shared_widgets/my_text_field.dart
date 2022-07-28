import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/styles/colors.dart';
import '../../utils/styles/cosntants.dart';

class MyTextField extends StatelessWidget {
  final hintText;
  final hintTextColor;
  bool obscureText;
  final borderColor;
  final maxLength;
  final borderRadius;
  final validatorText;
  final TextEditingController textController;

  MyTextField({
    Key? key,
    this.hintText,
    this.hintTextColor,
    this.maxLength,
    ault,
    this.obscureText = false,
    required this.borderColor,
    required this.validatorText,
    required this.textController,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController, //If Password hide it
      maxLength: maxLength,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorText;
        }
        return null;
      },
      style: GoogleFonts.poppins(
        fontSize: 13.0,
      ),
      cursorColor: greenColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: hintTextColor ?? blackColor.withOpacity(0.3),
          fontSize: 13.0,
        ),
        errorStyle: GoogleFonts.poppins(fontSize: 13.0),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? radius),
            borderSide: BorderSide(
              color: borderColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? radius),
            borderSide: BorderSide(
              color: borderColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? radius),
            borderSide: const BorderSide(
              color: transparentColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? radius),
            borderSide: const BorderSide(
              color: transparentColor,
            )),
      ),
    );
  }
}
