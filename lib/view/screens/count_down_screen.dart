import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_fonts.dart';
import '../../controller/count_down_controller.dart';

class CountDownScreen extends StatefulWidget {
  const CountDownScreen({Key? key}) : super(key: key);

  @override
  State<CountDownScreen> createState() => _CountDownScreenState();
}

class _CountDownScreenState extends State<CountDownScreen> {
  CountDownController countDownController = Get.put(CountDownController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Count Down')),
        body: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 50.0.h, right: 50.0.w, left: 50.0.w, bottom: 15.0.h),
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
                                countDownController.minutecounter.value
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
                                countDownController.secondcounter.value
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
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: countDownController.minutesTextController,
                    onSubmitted: (value) {
                      int newValue = int.parse(value);
                      countDownController.minutecounter.value = newValue;
                    },
                    decoration: InputDecoration(
                        label: const Text(
                          'Enter Minutes',
                          style: TextStyle(fontFamily: AppFonts.play),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        )),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: countDownController.secondsTextController,
                    onSubmitted: (value) {
                      int newValue = int.parse(value);
                      countDownController.secondcounter.value = newValue;
                    },
                    decoration: InputDecoration(
                        label: const Text(
                          'Enter Seconds',
                          style: TextStyle(fontFamily: AppFonts.play),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        )),
                  ),
                ),
                SizedBox(height: 150.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(onTap: () {
                        if (countDownController.isZeroingTaped.value == false) {
                          countDownController.zeroingCounter();
                          Fluttertoast.showToast(
                              msg: 'Counter Zeroing',
                              backgroundColor: AppColors.mainColor,
                              fontSize: 15.sp,
                              textColor: Colors.white,
                              gravity: ToastGravity.CENTER_LEFT);
                          countDownController.isZeroingTaped.value = true;
                          countDownController.isStopTaped.value = false;
                          countDownController.isStartTaped.value = false;
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
                            color: countDownController.isZeroingTaped.value
                                ? Colors.white
                                : AppColors.mainColor,
                            borderRadius: BorderRadius.circular(40.r),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius:
                                      countDownController.isZeroingTaped.value
                                          ? 15
                                          : 5,
                                  spreadRadius: 1,
                                  blurStyle: BlurStyle.outer
                                  // countDownController
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
                            color: countDownController.isZeroingTaped.value
                                ? AppColors.mainColor
                                : Colors.white,
                            // countDownController.timer.isActive? Colors.red : Colors.white,
                            size: 35,
                          )),
                        );
                      })),
                      InkWell(onTap: () {
                        if (countDownController.isStartTaped.value == false) {
                          countDownController.startDown();
                          Fluttertoast.showToast(
                              msg: 'Counter Stating',
                              backgroundColor: AppColors.mainColor,
                              fontSize: 15.sp,
                              textColor: Colors.white,
                              gravity: ToastGravity.CENTER_LEFT);
                          countDownController.isStartTaped.value = true;
                          countDownController.isStopTaped.value = false;
                          countDownController.isZeroingTaped.value = false;
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
                            color: countDownController.isStartTaped.value
                                ? Colors.white
                                : AppColors.mainColor,
                            borderRadius: BorderRadius.circular(40.r),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius:
                                      countDownController.isStartTaped.value
                                          ? 15
                                          : 5,
                                  spreadRadius: 1,
                                  blurStyle: BlurStyle.outer
                                  // countDownController
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
                            color: countDownController.isStartTaped.value
                                ? AppColors.mainColor
                                : Colors.white,
                            // countDownController.timer.isActive? Colors.red : Colors.white,
                            size: 35,
                          )),
                        );
                      })),
                      InkWell(onTap: () {
                        countDownController.stopCounting();
                        Fluttertoast.showToast(
                            msg: 'Counter Stopped',
                            backgroundColor: AppColors.mainColor,
                            fontSize: 15.sp,
                            textColor: Colors.white,
                            gravity: ToastGravity.CENTER_LEFT);
                        countDownController.isStopTaped.value = true;
                        countDownController.isStartTaped.value = false;
                        countDownController.isZeroingTaped.value = false;
                      }, child: Obx(() {
                        return Container(
                            height: 80.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius:
                                      countDownController.isStopTaped.value
                                          ? 15
                                          : 5,
                                  spreadRadius: 1,
                                  blurStyle: BlurStyle.outer,

                                  /// Remember to change the style of blurStule when press the button.
                                ),
                              ],
                              color: countDownController.isStopTaped.value
                                  ? Colors.white
                                  : AppColors.mainColor,
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                            child: const Center(
                                child: Icon(
                              Icons.stop,
                              color: Colors.red,
                              //countDownController.timer.isActive? Colors.white : Colors.red,
                              size: 35,
                            )));
                      })),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ],
        ));
  }
}
