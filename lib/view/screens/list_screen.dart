import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:world_time/constant/app_colors.dart';
import 'package:world_time/constant/app_fonts.dart';
import 'package:world_time/constant/app_utils.dart';
import 'package:world_time/controller/list_controller.dart';

import '../widgets/weatherListContainer.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  ListController listController = Get.put(ListController());

  @override
  Widget build(BuildContext context) {
    final nameStream =
        Supabase.instance.client.from('test_table').stream(primaryKey: ['id']);

    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('World Time'),
          ),
          body: snapshot.data == ConnectivityResult.none
              ? Utils.noInternet
              : StreamBuilder<List<Map<String, dynamic>>>(
                  stream: nameStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitThreeInOut(
                          color: AppColors.mainColor,
                          size: 30,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final names = snapshot.data!;
                      return ListView(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 30.0.h, right: 290.w),
                                child: Text(
                                  'My List',
                                  style: TextStyle(
                                      fontFamily: AppFonts.play,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              const Divider(
                                endIndent: 30,
                                indent: 30,
                                color: Colors.black,
                              ),
                              SizedBox(height: 10.h),

                              /// List

                              SizedBox(
                                height: 650.h,
                                child: ListView.builder(
                                    itemCount: names.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: 20.0.w,
                                            left: 20.0.w,
                                            bottom: 15.0.h),
                                        child: InkWell(
                                          onTap: () async {
                                            const Center(
                                                child: SpinKitThreeInOut(
                                                    color:
                                                        AppColors.mainColor));

                                            await listController
                                                .getTapedCityData(
                                              names[index][
                                                  'name'], /*listController.favorites[index]*/
                                            );
                                            await listController
                                                .getCityWeather();

                                            Get.bottomSheet(
                                              Container(
                                                height: 450.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  20.r)),
                                                ),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 30.0.h,
                                                          left: 20.w,
                                                          right: 20.w),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          /// Address
                                                          Center(
                                                            child: Text(
                                                              listController
                                                                  .tapedCityName
                                                                  .value,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      AppFonts
                                                                          .play,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.sp),
                                                            ),
                                                          ),
                                                          SizedBox(height: 5.h),
                                                          Divider(
                                                            color: AppColors
                                                                .mainColor,
                                                            height: 2.h,
                                                            endIndent: 30.w,
                                                            indent: 30.w,
                                                          ),
                                                          SizedBox(
                                                              height: 30.h),

                                                          WeatherListContainer(
                                                            listController:
                                                                listController,
                                                            type: 'Temp',
                                                            data:
                                                                '${listController.temp}℃',
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          WeatherListContainer(
                                                            listController:
                                                                listController,
                                                            type: 'Main',
                                                            data:
                                                                '${listController.main}',
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          WeatherListContainer(
                                                            listController:
                                                                listController,
                                                            type: 'Desc',
                                                            data:
                                                                '${listController.description}',
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          WeatherListContainer(
                                                            listController:
                                                                listController,
                                                            type: 'Date',
                                                            data:
                                                                '${listController.tapedCityDate}',
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          WeatherListContainer(
                                                            listController:
                                                                listController,
                                                            type: 'Day',
                                                            data:
                                                                '${listController.tapedCityDay}',
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          WeatherListContainer(
                                                            listController:
                                                                listController,
                                                            type: 'Max Temp',
                                                            data:
                                                                '${listController.tempMax}℃',
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          WeatherListContainer(
                                                            listController:
                                                                listController,
                                                            type: 'Min Temp',
                                                            data:
                                                                '${listController.tempMin}℃',
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          WeatherListContainer(
                                                            listController:
                                                                listController,
                                                            type: 'W.Speed',
                                                            data:
                                                                '${listController.windSpeed}',
                                                          ),

                                                          SizedBox(
                                                              height: 10.h),
                                                          WeatherListContainer(
                                                            listController:
                                                                listController,
                                                            type: 'W.Degree',
                                                            data:
                                                                '${listController.windDeg}',
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 150.h,
                                            width: 280.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                color: AppColors.blue),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image(
                                                    height: 50.h,
                                                    width: 50.w,
                                                    image: const AssetImage(
                                                        'images/container_clock.png'),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 60.h),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          names[index]['name'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  AppFonts.play,
                                                              fontSize: 20.sp),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      listController
                                                          .removeFromFavorites(
                                                        names[index]['id'],
                                                        /*listController
                                                  .favorites[index]*/
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Utils.noItems,
                      );
                    }
                  },
                ),
        );
      },
    );
  }
}
