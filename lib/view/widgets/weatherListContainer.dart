import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_fonts.dart';
import '../../controller/list_controller.dart';
class WeatherListContainer extends StatelessWidget {
  const WeatherListContainer({
    super.key,
    required this.listController, required this.type, required this.data,
  });

  final ListController listController;

  final String type;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 70.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            '$type :  $data',
            style: TextStyle(
                fontFamily: AppFonts.play,
                color: Colors.black,
                fontSize: 20.sp),
          ),
        ),
      ),
    );
  }
}