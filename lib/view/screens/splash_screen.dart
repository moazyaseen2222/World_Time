// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:world_time/constant/app_colors.dart';
// import 'package:world_time/constant/app_fonts.dart';
// import 'package:world_time/constant/routes.dart';
// import 'package:world_time/constant/routes_name.dart';
// import 'package:world_time/view/screens/home_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Future.delayed(const Duration(seconds: 2), () {
//       Get.offNamed(RoutesName.bnScreen);
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.mainColor,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Image(
//                 image: AssetImage(
//               'images/logo.png',
//             )),
//             SizedBox(height: 20.h),
//             Text(
//               'World Time',
//               style: TextStyle(
//                   letterSpacing: 3,
//                   fontFamily: AppFonts.play,
//                   fontSize: 40.sp,
//                   color: Colors.white),
//             ),
//           ],
//         ));
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:world_time/constant/app_colors.dart';
import 'package:world_time/constant/app_fonts.dart';

import 'bn_screen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 2.0;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(const Duration(seconds: 3), () {
      setState(() {
        Navigator.pushReplacement(
            context,
            PageTransition(
              const BnScreen(),
            ));
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _height / _fontSize),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: Text(
                  'WORLD TIME',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppFonts.play,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1500),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: /* _width / _containerSize*/ 500,
                  width: /* _width / _containerSize*/ 500,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  // child: Image.asset('assets/images/file_name.png')
                  child: const Image(
                    height: 300,
                    width: 300,
                    image: AssetImage('images/logo.png'),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}


