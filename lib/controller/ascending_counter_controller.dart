import 'dart:async';

import 'package:get/get.dart';

class AscendingCounterController extends GetxController {
  RxInt secondcounter = 00.obs;
  RxInt meniutcounter = 0.obs;
  late Timer timer;
  RxBool isStartTaped = false.obs;
  RxBool isStopTaped = false.obs;
  RxBool isZeroingTaped = false.obs;

  void startCounting() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondcounter.value++;
      if (secondcounter.value == 60) {
        meniutcounter.value++;
        secondcounter.value = 0;
      }
    });
  }

  void stopCounting() {
    timer.cancel();
  }

  void zeroingCounter() {
    timer.cancel();
    secondcounter.value = 0;
    meniutcounter.value = 0;
  }
}
