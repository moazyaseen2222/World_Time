import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:world_time/constant/app_colors.dart';

import '../../constant/app_fonts.dart';

class settings_container extends StatelessWidget {
  const settings_container({
    super.key,
    required this.title,
    required this.imageName,
    this.onPressed,
  });

  final String title;
  final AssetImage imageName;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 100.h,
          width: 400.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r), color: AppColors.blue),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontFamily: AppFonts.play, fontSize: 25.sp),
                ),
                Image(
                  height: 40.h,
                    width: 40.w,
                    image: imageName),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
