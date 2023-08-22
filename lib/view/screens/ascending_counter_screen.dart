import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:world_time/constant/app_colors.dart';
import 'package:world_time/constant/app_fonts.dart';

import '../../controller/ascending_counter_controller.dart';

class AscendingCounterScreen extends StatefulWidget {
  const AscendingCounterScreen({Key? key}) : super(key: key);

  @override
  State<AscendingCounterScreen> createState() => _AscendingCounterScreenState();
}

class _AscendingCounterScreenState extends State<AscendingCounterScreen> {
  AscendingCounterController ascendingCounterController =
      Get.put(AscendingCounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Ascending Counter')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                height: 300.h,
                width: 300.w,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Center(child: Obx(() {
                  return Column(
                    children: [
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Timer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                              fontFamily: AppFonts.play,
                            ),
                          ),
                          SizedBox(width: 7.w),
                          const Icon(
                            Icons.timer_sharp,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ),
                      SizedBox(height: 50.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ascendingCounterController.meniutcounter.value
                                .toString(),
                            style: TextStyle(
                                fontFamily: AppFonts.play,
                                color: Colors.white,
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ':',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50.sp,
                                fontFamily: AppFonts.play),
                          ),
                          Text(
                            ascendingCounterController.secondcounter.value
                                .toString(),
                            style: TextStyle(
                                fontFamily: AppFonts.play,
                                color: Colors.white,
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  );
                })),
              ),
            ),
            SizedBox(height: 250.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: () {
                    if (ascendingCounterController.isZeroingTaped.value ==
                        false) {
                      ascendingCounterController.zeroingCounter();
                      Fluttertoast.showToast(
                          msg: 'Counter Zeroing',
                          backgroundColor: AppColors.mainColor,
                          fontSize: 15.sp,
                          textColor: Colors.white,
                          gravity: ToastGravity.CENTER_LEFT);
                      ascendingCounterController.isZeroingTaped.value = true;
                      ascendingCounterController.isStopTaped.value = false;
                      ascendingCounterController.isStartTaped.value = false;
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Timer already Zero',
                          backgroundColor: AppColors.mainColor,
                          fontSize: 15.sp,
                          textColor: Colors.white,
                          gravity: ToastGravity.CENTER_LEFT);
                    }
                  }, child: Obx(() {
                    return Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: ascendingCounterController.isZeroingTaped.value
                            ? Colors.white
                            : AppColors.mainColor,
                        borderRadius: BorderRadius.circular(40.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: ascendingCounterController
                                      .isZeroingTaped.value
                                  ? 15
                                  : 5,
                              spreadRadius: 1,
                              blurStyle: BlurStyle.outer
                              // ascendingCounterController
                              //             .timer.isActive
                              //     ? BlurStyle.outer
                              //     : BlurStyle.normal,

                              /// Remember to change the style of blurStule when press the button.
                              ),
                        ],
                      ),
                      child: Center(
                          child: Icon(
                        Icons.restart_alt_sharp,
                        color: ascendingCounterController.isZeroingTaped.value
                            ? AppColors.mainColor
                            : Colors.white,
                        // ascendingCounterController.timer.isActive? Colors.red : Colors.white,
                        size: 35,
                      )),
                    );
                  })),
                  InkWell(onTap: () {
                    if (ascendingCounterController.isStartTaped.value ==
                        false) {
                      ascendingCounterController.startCounting();
                      Fluttertoast.showToast(
                          msg: 'Counter Stating',
                          backgroundColor: AppColors.mainColor,
                          fontSize: 15.sp,
                          textColor: Colors.white,
                          gravity: ToastGravity.CENTER_LEFT);
                      ascendingCounterController.isStartTaped.value = true;
                      ascendingCounterController.isStopTaped.value = false;
                      ascendingCounterController.isZeroingTaped.value = false;
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Timer already counting',
                          backgroundColor: AppColors.mainColor,
                          fontSize: 15.sp,
                          textColor: Colors.white,
                          gravity: ToastGravity.CENTER_LEFT);
                    }
                  }, child: Obx(() {
                    return Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: ascendingCounterController.isStartTaped.value
                            ? Colors.white
                            : AppColors.mainColor,
                        borderRadius: BorderRadius.circular(40.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius:
                                  ascendingCounterController.isStartTaped.value
                                      ? 15
                                      : 5,
                              spreadRadius: 1,
                              blurStyle: BlurStyle.outer
                              // ascendingCounterController
                              //             .timer.isActive
                              //     ? BlurStyle.outer
                              //     : BlurStyle.normal,

                              /// Remember to change the style of blurStule when press the button.
                              ),
                        ],
                      ),
                      child: Center(
                          child: Icon(
                        Icons.play_arrow,
                        color: ascendingCounterController.isStartTaped.value
                            ? AppColors.mainColor
                            : Colors.white,
                        // ascendingCounterController.timer.isActive? Colors.red : Colors.white,
                        size: 35,
                      )),
                    );
                  })),
                  InkWell(onTap: () {
                    if (ascendingCounterController.isStopTaped.value) {
                      Fluttertoast.showToast(
                          msg: 'Timer already stopped',
                          backgroundColor: AppColors.mainColor,
                          fontSize: 15.sp,
                          textColor: Colors.white,
                          gravity: ToastGravity.CENTER_LEFT);
                    } else {
                      ascendingCounterController.stopCounting();
                      Fluttertoast.showToast(
                          msg: 'Counter Stopped',
                          backgroundColor: AppColors.mainColor,
                          fontSize: 15.sp,
                          textColor: Colors.white,
                          gravity: ToastGravity.CENTER_LEFT);
                      ascendingCounterController.isStopTaped.value = true;
                      ascendingCounterController.isStartTaped.value = false;
                      ascendingCounterController.isZeroingTaped.value = false;
                    }
                  }, child: Obx(() {
                    return Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius:
                                  ascendingCounterController.isStopTaped.value
                                      ? 15
                                      : 5,
                              spreadRadius: 1,
                              blurStyle: BlurStyle.outer,

                              /// Remember to change the style of blurStule when press the button.
                            ),
                          ],
                          color: ascendingCounterController.isStopTaped.value
                              ? Colors.white
                              : AppColors.mainColor,
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.stop,
                          color: Colors.red,
                          //ascendingCounterController.timer.isActive? Colors.white : Colors.red,
                          size: 35,
                        )));
                  })),
                ],
              ),
            )
          ],
        ));
  }
}
