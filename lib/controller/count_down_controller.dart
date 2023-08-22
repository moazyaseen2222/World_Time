import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CountDownController extends GetxController {
  RxInt secondcounter = 00.obs;
  RxInt minutecounter = 0.obs;
  late Timer timer;
  RxBool isStartTaped = false.obs;
  RxBool isStopTaped = false.obs;
  RxBool isZeroingTaped = false.obs;




  TextEditingController minutesTextController = TextEditingController();
  TextEditingController secondsTextController = TextEditingController();

  @override
  void onInit() async {
    minutesTextController = TextEditingController();
    secondsTextController = TextEditingController();


    super.onInit();
  }

  void startDown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondcounter.value != 0 || minutecounter.value != 0) {
        secondcounter.value--;
        if (secondcounter.value == 0 && minutecounter.value != 0) {
          minutecounter.value--;
          secondcounter.value = 60;
        }
      } else {

      }
    });
  }

  void stopCounting() {
    timer.cancel();
  }

  void zeroingCounter() {
    timer.cancel();
    secondcounter.value = 0;
    minutecounter.value = 0;
  }

// void _playSound() async {
//   await audioPlayer.play('sounds/time_out.mp3');
// }
}
