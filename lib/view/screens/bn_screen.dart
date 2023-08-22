import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_time/constant/app_fonts.dart';
import '../../controller/bn_controller.dart';

class BnScreen extends StatefulWidget {
  const BnScreen({Key? key}) : super(key: key);

  @override
  State<BnScreen> createState() => _BnScreenState();
}

class _BnScreenState extends State<BnScreen> {
  BnController bnController = Get.put(BnController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.scaffold,
      body: Obx(() {
        return bnController.screens[bnController.currentIndex.value].widget;
      }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20.0.h),
        child: Obx(() {
          return BottomNavigationBar(
            onTap: (int index) {
              bnController.currentIndex.value = index;
            },
            currentIndex: bnController.currentIndex.value,
            elevation: 0,
            selectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(
              fontFamily: AppFonts.play,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: AppFonts.play,
            ),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.access_time,
                    size: 30,
                  ),
                  label: 'CLOCK',
                  activeIcon: Icon(Icons.access_time_filled, size: 30,)
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    size: 30,
                  ),
                  label: 'LIST'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outline_sharp,
                    size: 30,
                  ),
                  activeIcon: Icon(Icons.person, size: 30,),
                  label: 'PROFILE'),

            ],
          );
        }),
      ),
    );
  }
}
