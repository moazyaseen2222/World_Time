import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_fonts.dart';

class CustomFormFiled extends StatelessWidget {
  const CustomFormFiled(
      {Key? key,
      required this.hintText,
      this.inputFormatters,
      this.validator,
      required this.label})
      : super(key: key);

  final String hintText;
  final String label;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
          helperText: hintText,
          label: Text(
            label,
            style: const TextStyle(fontFamily: AppFonts.play),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
          )),
    );
  }
}
