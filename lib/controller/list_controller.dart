import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constant/app_colors.dart';

class ListController extends GetxController {
  TextEditingController searchController = TextEditingController();

  RxList favorites = [].obs;
  RxString tapedCityName = ''.obs;
  RxString tapedCityTime = '00:00'.obs;
  RxString tapedCityDate = ''.obs;
  RxString tapedCityDay = ''.obs;
  late SharedPreferences sharedPreferences;
  //List<String> itemList = [];

  // final nameStream =
  // Supabase.instance.client.from('savedCity').stream(primaryKey: ['id']);


  List<String>? cities = [];

////////////////////////////////////////////
  RxInt temp = 0.obs;
  RxString main = 'main'.obs;
  RxString description = 'description'.obs;
  RxString icon = 'icon'.obs;
  RxInt tempMax = 0.obs;
  RxInt tempMin = 0.obs;
  RxDouble windSpeed = 0.0.obs;
  RxInt windDeg = 0.obs;

  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    searchController.dispose();
    super.onInit();
  }

  addToFavorite(String cityName) async {
    favorites.add(cityName);

    await Supabase.instance.client
        .from('test_table')
        .insert({'name': cityName});

    //saveItem(cityName);



    // final SharedPreferences sharedPreferences =
    //     await SharedPreferences.getInstance();
    //
    // await sharedPreferences
    //     .setStringList('favorites', <String>[favorites.toString()]);
    //
    // cities = sharedPreferences.getStringList('favorites');

    Fluttertoast.showToast(
        msg: 'City saved to list',
        fontSize: 15.sp,
        backgroundColor: AppColors.blue,
        textColor: Colors.black);
  }

  // Save item and add it to the list
  void saveItem(String item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemList = prefs.getStringList('myList') ?? [];
    itemList.add(item);
    await prefs.setStringList('myList', itemList);
  }

  // Retrieve saved list of strings
  Future<List<String>> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('myList') ?? [];
  }

  removeFromFavorites(int id) async {
    favorites.remove(id);
    await Supabase.instance.client
        .from('test_table')
        .delete()
        .match({ 'id': id });
  }

  Future<Map<String, dynamic>> getTapedCityData(String cityName) async {
    tapedCityName.value = cityName;
    String url =
        'https://www.timeapi.io/api/Time/current/zone?timeZone=${tapedCityName.value}';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      tapedCityTime.value = jsonData['time'];
      tapedCityDate.value = jsonData['date'];
      tapedCityDay.value = jsonData['dayOfWeek'];
      return jsonData;
    } else {
      return {};
    }
  }

  Future<dynamic> getCityWeather() async {
    RxList<String> parts = tapedCityName.value.split("/").obs;
    RxString tapedCityNameWeather = parts[1].trim().obs;

    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$tapedCityNameWeather&appid=4226910c384a338acc7c7cfe6a86d4b0';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      temp.value = jsonData['main']['temp'] / 10 ~/ 1;
      tempMax.value = jsonData['main']['temp_max'] / 10 ~/ 1;
      tempMin.value = jsonData['main']['temp_min'] / 10 ~/ 1;
      main.value = jsonData['weather'][0]['main'];
      description.value = jsonData['weather'][0]['description'];
      icon.value = jsonData['weather'][0]['icon'];
      windSpeed.value = jsonData['wind']['speed'];
      windDeg.value = jsonData['wind']['deg'];
      return jsonData;
    } else {
      return {};
    }
  }
}
