import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_fonts.dart';

class Utils {
  static Widget noInternet = Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.wifi_off_sharp,
        size: 50,
      ),
      Text(
        'No Internet',
        style: TextStyle(fontFamily: AppFonts.play, fontSize: 20.sp),
      ),
    ],
  ));
  static Widget noItems = Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(height: 200.h),
      const Icon(
        Icons.hourglass_empty_sharp,
        size: 50,
      ),
      SizedBox(height: 10.h),
      DefaultTextStyle(
        style: TextStyle(
            fontFamily: AppFonts.play, fontSize: 20.sp, color: Colors.black),
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              'No Items!',
            ),
          ],
          repeatForever: true,
          isRepeatingAnimation: true,
        ),
      ),

      // Text(
      //   'No Items',
      //   style: TextStyle(fontFamily: AppFonts.play, fontSize: 20.sp),
      // )
    ],
  ));
}
