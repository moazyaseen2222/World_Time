import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_time/constant/app_colors.dart';
import 'package:world_time/constant/app_fonts.dart';
import '../../controller/home_controller.dart';
import '../../controller/settings_controller.dart';
import '../widgets/settings_container.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsController settingsController = Get.put(SettingsController());
  HomeController homeController = Get.put(HomeController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Get.bottomSheet(Container(
                      height: 470.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.r),
                            topLeft: Radius.circular(20.r)),
                      ),
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 20.h),
                              Text(
                                'Edit Profile',
                                style: TextStyle(
                                    fontFamily: AppFonts.play,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 30.h),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          // validator: (value) {
                                          //   if (value!.isNotEmpty) {
                                          //     nameIsOk = true;
                                          //   } else {
                                          //     Get.snackbar(
                                          //         'Oops', 'Enter your name');
                                          //   }
                                          // },
                                          controller:
                                              settingsController.nameController,
                                          decoration: InputDecoration(
                                              label: const Text(
                                                'Name',
                                                style: TextStyle(
                                                    fontFamily: AppFonts.play),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          // validator: (value) {
                                          //   if (value!.isNotEmpty) {
                                          //     cityNameIsOk = true;
                                          //   } else {
                                          //     Get.snackbar(
                                          //         'Oops', 'Enter country name');
                                          //   }
                                          // },
                                          controller: settingsController
                                              .cityNameController,
                                          decoration: InputDecoration(
                                              label: const Text(
                                                'Country, City',
                                                style: TextStyle(
                                                    fontFamily: AppFonts.play),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                              )),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          settingsController.imagePath == ''
                                              ? Container(
                                                  color: Colors.red,
                                                )
                                              : Obx(() {
                                                  return CircleAvatar(
                                                    radius: 40.r,
                                                    //backgroundImage: const AssetImage('images/mi.jpeg'),
                                                    backgroundImage:
                                                        settingsController
                                                                .imagePath
                                                                .isNotEmpty
                                                            ? FileImage(File(
                                                                settingsController
                                                                    .imagePath
                                                                    .toString()))
                                                            : null,

                                                    // FileImage(File(settingsController.image.toString())),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        settingsController
                                                            .imagePath
                                                            .value = '';
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r)),
                                              child: IconButton(
                                                onPressed: () {
                                                  settingsController.getImage();
                                                },
                                                icon: const Icon(
                                                  Icons.image_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize:
                                                  Size(double.infinity, 60.h),
                                              backgroundColor:
                                                  AppColors.mainColor),
                                          onPressed: () {
                                            settingsController.save(
                                              settingsController
                                                  .nameController.text,
                                              settingsController
                                                  .cityNameController
                                                  .text, /*settingsController.image*/
                                            );

                                            settingsController.nameController
                                                .clear();
                                            settingsController
                                                .cityNameController
                                                .clear();
                                            Get.back();
                                            Get.snackbar(
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                'Edit',
                                                'Your info has been edited');

                                            // Get.snackbar(
                                            //     snackPosition: SnackPosition.BOTTOM,
                                            //     'Oops',
                                            //     'Fill all data');
                                          },
                                          child: const Text(
                                            'Save',
                                            style: TextStyle(
                                                fontFamily: AppFonts.play),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      )));
                },
                icon: const Icon(Icons.edit_sharp))
          ],
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 239.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.r),
                              bottomRight: Radius.circular(40.r))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          Center(child: Obx(() {
                            return Text(
                              settingsController.name.value,
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  fontFamily: AppFonts.play,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            );
                          })),
                          SizedBox(height: 10.h),
                          Center(child: Obx(() {
                            return Text(
                              settingsController.cityName.value,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: AppFonts.play,
                                  color: const Color(0xff66718D)),
                            );
                          }))
                        ],
                      ),
                    ),
                    Obx(() {
                      return Padding(
                        padding: EdgeInsets.only(top: 150.0.h, left: 130.w),
                        child: CircleAvatar(
                            radius: 80.r,
                            backgroundImage: settingsController
                                    .imagePath.isNotEmpty
                                ? FileImage(File(
                                    settingsController.imagePath.toString()))
                                : null),
                      );
                    })
                  ],
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0.w,
                  ),
                  child: Text(
                    'Social Media',
                    style: TextStyle(
                        fontFamily: AppFonts.play,
                        fontSize: 25.sp,
                        color: AppColors.mainColor),
                  ),
                ),
                SizedBox(height: 20.h),
                  settings_container(
                  title: 'LinkedIn',
                  imageName: const AssetImage('images/linkedin.png'),
                   onPressed: (){
                     settingsController.launchURL('https://www.linkedin.com/in/moazyaseen/');
                   },
                ),
                SizedBox(height: 10.h),
                  settings_container(
                  title: 'WhatsApp',
                  imageName: const AssetImage('images/whatsapp.png'),
                   onPressed: (){
                     settingsController.launchURL('http://Wa.me/972592145316');
                   },
                ),
                SizedBox(height: 10.h),
                 settings_container(
                    title: 'Twitter',
                    imageName: const AssetImage('images/twitter.png'),
                    onPressed: (){
                      settingsController.launchURL('https://twitter.com/yaseen_moaz');
                    },
                    // icon: Obx(() {
                    //   // return Switch(
                    //   //     value: settingsController.is24Hour.value,
                    //   //     onChanged: (bool value) {
                    //   //       settingsController.is24Hour.value = value;
                    //   //       // homeController.convertTime(homeController.time.value);
                    //   //     });
                    // })
                ),
              ],
            ),
          ],
        ));
  }
}
