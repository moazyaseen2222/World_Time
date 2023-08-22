import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  TextEditingController searchCityController = TextEditingController();

  RxInt continentId = 1.obs;
  RxString continentName = 'Choose Time Zone'.obs;
  final selectedItem = Rx<dynamic>(null);

  // final List<ContinentsDropDown> continents = <ContinentsDropDown>[
  //   ContinentsDropDown(title: 'Choose Continent', value: 'Choose Time Zone'),
  //   ContinentsDropDown(title: 'Africa', value: 'Africa'),
  //   ContinentsDropDown(title: 'America', value: 'America'),
  //   ContinentsDropDown(title: 'Antarctica', value: 'Antarctica'),
  //   ContinentsDropDown(title: 'Atlantic', value: 'Atlantic'),
  //   ContinentsDropDown(title: 'Europe', value: 'Europe'),
  //   ContinentsDropDown(title: 'Indian', value: 'Indian'),
  //   ContinentsDropDown(title: 'Pacific', value: 'Pacific'),
  //   ContinentsDropDown(title: 'Asia', value: 'Asia'),
  // ];

  @override
  void onInit() {
    searchCityController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    searchCityController.dispose();
    super.onClose();
  }

  RxString cityName = 'World Time'.obs;

  // RxString searchYourCity = ' Search Your City'.obs;
  RxString time = '--'.obs;
  RxBool isAM = false.obs;
  RxBool isLiked = false.obs;


  ///
  RxInt temp = 0.obs;
  RxString main = 'main'.obs;
  RxString description = 'description'.obs;
  RxString icon = 'icon'.obs;
  RxString iconName = 'images/hot.png'.obs;
  RxInt tempMax = 0.obs;
  RxInt tempMin = 0.obs;
  RxInt humidity = 0.obs;
  RxInt pressure = 0.obs;
  RxDouble windSpeed = 0.0.obs;
  RxInt windDeg = 0.obs;
  RxDouble lat = 0.0.obs;
  RxDouble lon = 0.0.obs;

  // String icon =homeController.iconStatus();



  void iconStatus() {
    if (main.value == 'Clear') {
      iconName.value =  'images/sun.png';
    } else if (main.value == 'Clouds') {
      iconName.value = 'images/cloudy.png';
    } else if (main.value == 'Rain') {
      iconName.value = 'images/rain.png';
    } else {
      iconName.value = 'images/logo.png';
    }
  }

  Future<Map<String, dynamic>> searchCity() async {
    String url =
        'https://www.timeapi.io/api/Time/current/zone?timeZone=${continentName.value}/${searchCityController.text}';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      cityName.value = jsonData['timeZone'] ?? 'World Time';
      time.value = jsonData['time'] ?? '-';
      return jsonData;
    } else {
      return {};
    }
  }

  Future<dynamic> getCityWeather() async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=${searchCityController.text}&appid=4226910c384a338acc7c7cfe6a86d4b0';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      temp.value = jsonData['main']['temp'] / 10 ~/ 1;
      tempMax.value = jsonData['main']['temp_max'] / 10 ~/ 1;
      tempMin.value = jsonData['main']['temp_min'] / 10 ~/ 1;
      humidity.value = jsonData['main']['humidity'];
      pressure.value = jsonData['main']['pressure'];
      windSpeed.value = jsonData['wind']['speed'];
      windDeg.value = jsonData['wind']['deg'];
      //cityName.value = jsonData['name'];
      main.value = jsonData['weather'][0]['main'];
      lon.value = jsonData['coord']['lon'];
      lat.value = jsonData['coord']['lat'];
      description.value = jsonData['weather'][0]['description'];
      icon.value = jsonData['weather'][0]['icon'];
      return jsonData;
    } else {
      return {};
    }
  }

// Future<List<Forecast>> getForecast() async {
//   print('FORECAST BEGIN...');
//   String url =
//       'https://api.openweathermap.org/data/2.5/forecast?q=${searchCityController.text}&appid=4226910c384a338acc7c7cfe6a86d4b0';
//   var response = await http.get(Uri.parse(url));
//   print(response.statusCode);
//   if (response.statusCode == 200) {
//     // print(response);
//     var jsonData = jsonDecode(response.body) /*as List*/;
//     print(jsonData['list'][0]['main']['temp']);
//     var data = jsonData['list'] as List;
//    // print(data);
//     return data.map((e) => Forecast.fromJson(e)).toList();
//   } else {
//     return [];
//   }
// }
}
