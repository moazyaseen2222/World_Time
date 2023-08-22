import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:world_time/constant/app_colors.dart';
import 'package:world_time/constant/app_fonts.dart';
import 'package:world_time/constant/app_utils.dart';
import '../../controller/home_controller.dart';
import '../../controller/list_controller.dart';
import 'ascending_counter_screen.dart';
import 'count_down_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  ListController listController = Get.put(ListController());

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('World Time'),
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: PopupMenuButton<int>(
                  icon: const Icon(Icons.timer_sharp),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 1,
                        child: Text('Ascending counter',
                            style: TextStyle(fontFamily: AppFonts.play)),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text('Countdown',
                            style: TextStyle(fontFamily: AppFonts.play)),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 1) {
                      Get.to(const AscendingCounterScreen());
                    } else {
                      Get.to(const CountDownScreen());
                    }
                  },
                ),
              ),
              // actions: [
              //   IconButton(onPressed: () {}, icon: const Icon(Icons.language))
              // ],
            ),
            body: snapshot.data == ConnectivityResult.none
                ? Utils.noInternet
                : ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.0.h,
                          left: 20.w,
                          right: 20.w,
                        ),
                        child: Column(
                          children: [
                            Obx(() {
                              return DropdownButton(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  // value: homeController.continentName.value,
                                  style: const TextStyle(
                                      fontFamily: AppFonts.play,
                                      color: Colors.black),
                                  hint:
                                      Text(homeController.continentName.value),
                                  // homeController.continentName.value.isNotEmpty? Text(homeController.continentName.value): const Text('Choose Continent'),

                                  ///replaced the hint with the current value on continentName , because the value occurs error
                                  isExpanded: true,
                                  items: const [
                                    DropdownMenuItem<String>(
                                      value: 'Africa',
                                      child: Text('Africa'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Asia',
                                      child: Text('Asia'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'America',
                                      child: Text('America'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Antarctica',
                                      child: Text('Antarctica'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Atlantic',
                                      child: Text('Atlantic'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Europe',
                                      child: Text('Europe'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Indian',
                                      child: Text('Indian'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Pacific',
                                      child: Text('Pacific'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Australia',
                                      child: Text('Australia'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Brazil',
                                      child: Text('Brazil'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'US',
                                      child: Text('US'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Canada',
                                      child: Text('Canada'),
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    homeController.continentName.value = value!;
                                  });
                            }),
                            TextField(
                              controller: homeController.searchCityController,
                              onSubmitted: (value) async {
                                await homeController.getCityWeather();
                                //await homeController.getForecast();
                                var response =
                                    await homeController.searchCity();
                                if (!response.isNotEmpty) {
                                  Get.snackbar(
                                      'Oops', 'Not available time zone or city',
                                      snackPosition: SnackPosition.BOTTOM,
                                      icon: const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ));
                                }
                                homeController.searchCityController.clear();
                                homeController.continentName.value =
                                    'Choose Time Zone';

                                homeController.iconStatus();


                                ///
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search),
                                  // constraints: BoxConstraints(
                                  //     maxWidth: 250.w
                                  // ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  label: const Text(
                                    'Search city',
                                    style: TextStyle(fontFamily: AppFonts.play),
                                  )),
                            ),

                            /// Data
                            Obx(() {
                              return FutureBuilder<Map<String, dynamic>>(
                                future: HomeController().searchCity(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: SpinKitThreeInOut(
                                        color: AppColors.mainColor,
                                        size: 30,
                                      ),
                                    );
                                  } else if (snapshot.hasData) {
                                    // homeController.cityName.value = snapshot.data!['timeZone'];
                                    // homeController.time.value = snapshot.data!['time'];

                                    return Padding(
                                      padding: EdgeInsets.only(top: 20.0.h),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              /// Country Name
                                              Obx(() {
                                                return Text(
                                                  homeController.cityName.value
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily: AppFonts.play,
                                                      color: AppColors.pink,
                                                      fontSize: 25.sp),
                                                );
                                              }),
                                              SizedBox(width: 20.w),

                                              /// Time
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Obx(() {
                                                    return Column(
                                                      children: [
                                                        Text(
                                                          homeController
                                                              .time.value
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  AppFonts.play,
                                                              fontSize: 25.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    );
                                                  })
                                                  // Text(
                                                  //   ' PM',
                                                  //   style: TextStyle(
                                                  //       fontFamily: AppFonts.play,
                                                  //       fontSize: 40.sp,
                                                  //       fontWeight: FontWeight.bold),
                                                  // )
                                                ],
                                              ),
                                              //  SizedBox(height: 70.h),
                                              //  SizedBox(height: 10.h),
                                              // SizedBox(width: 10.w),
                                            ],
                                          ),
                                          SizedBox(height: 15.h),
                                          FutureBuilder<dynamic>(
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                  child: SpinKitThreeInOut(
                                                    color: AppColors.mainColor,
                                                    size: 30,
                                                  ),
                                                );
                                              } else if (snapshot.hasData) {
                                                return Obx(() {
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                Colors.indigo
                                                                    .shade100,
                                                                Colors.indigo
                                                                    .shade200,
                                                                const Color(
                                                                    0xffBAD7E9),
                                                                // Colors.pink.shade100,
                                                                // Colors.yellow.shade100
                                                              ]),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r),
                                                        ),
                                                        height: 210.h,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: 30.h,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  /// Temp
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        '${homeController.temp.value}' /*🌡*/,
                                                                        style: TextStyle(
                                                                            color:
                                                                                /*AppColors.mainColor,*/
                                                                                Colors.white,
                                                                            fontFamily: AppFonts.play,
                                                                            fontSize: 50.sp,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                        '℃' /*🌡*/,
                                                                        style: TextStyle(
                                                                            color:
                                                                                /* AppColors.mainColor,*/
                                                                                Colors.white,
                                                                            fontFamily: AppFonts.play,
                                                                            fontSize: 25.sp,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  // SizedBox(
                                                                  //     height:
                                                                  //         15.h),

                                                                  /// Status
                                                                  Text(
                                                                    homeController
                                                                        .main
                                                                        .value,
                                                                    style: TextStyle(
                                                                        color: /*AppColors
                                                                            .mainColor,*/
                                                                            Colors.white,
                                                                        fontFamily: AppFonts.play,
                                                                        fontSize: 25.sp),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          14.h),

                                                                  /// Description
                                                                  Text(
                                                                    homeController
                                                                        .description
                                                                        .value,
                                                                    style: TextStyle(
                                                                        color: /*AppColors
                                                                            .mainColor,*/
                                                                            Colors.white,
                                                                        fontFamily: AppFonts.play,
                                                                        fontSize: 20.sp),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 23.w),

                                                            ///Main Icon

                                                            Obx((){
                                                              return Image(
                                                                  image:
                                                                  AssetImage(
                                                                      homeController.iconName.value
                                                                  ),
                                                                  width: 130.w,
                                                                  height: 130.h,
                                                                  fit: BoxFit
                                                                      .cover);
                                                            }),


                                                            // homeController
                                                            //             .main ==
                                                            //         'Clear'
                                                            //     ? Image(
                                                            //         image: const AssetImage(
                                                            //             'images/sun.png'),
                                                            //         width:
                                                            //             150.w,
                                                            //         height:
                                                            //             150.h,
                                                            //         fit: BoxFit
                                                            //             .cover)
                                                            //     : Image(
                                                            //         fit: BoxFit
                                                            //             .cover,
                                                            //         height:
                                                            //             150.h,
                                                            //         width:
                                                            //             150.w,
                                                            //         image: AssetImage(
                                                            //             homeController
                                                            //                 .iconName
                                                            //                 .value)
                                                            //         // image: homeController.icon.value == '01d'? const AssetImage(
                                                            //         //     'images/cloudy.png') : const AssetImage(
                                                            //         //     'images/sun.png'),
                                                            //
                                                            //         ),
                                                            SizedBox(
                                                                height: 15.h),
                                                            // Container(
                                                            //   height: 200.h,
                                                            //   width: 200.w,
                                                            //   decoration: BoxDecoration(
                                                            //     color: Colors.grey
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 15.h),
                                                      Container(
                                                        width: 400.w,
                                                        height: 250.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                // // FFFBEB
                                                                //  Color(0xffFFFBEB),
                                                                //  Color(0xff495579),
                                                                //  Color(0xff263159),

                                                                // Color(0xff57C5B6),
                                                                // Color(0xffB0DAFF),
                                                                // Color(0xffA5D7E8),

                                                                Colors.red
                                                                    .shade100,
                                                                Colors.blue
                                                                    .shade100,
                                                                Colors.orange
                                                                    .shade100
                                                              ]),
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      20.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Min Temp :${homeController.tempMin.value} C',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            AppFonts
                                                                                .play,
                                                                        fontSize:
                                                                            20.sp),
                                                                  ),
                                                                  Text(
                                                                    'Max Temp :${homeController.tempMax.value} C',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            AppFonts
                                                                                .play,
                                                                        fontSize:
                                                                            20.sp),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      20.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Humidity :${homeController.humidity.value}%',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            AppFonts
                                                                                .play,
                                                                        fontSize:
                                                                            20.sp),
                                                                  ),
                                                                  Text(
                                                                    'Pressure :${homeController.pressure.value}',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            AppFonts
                                                                                .play,
                                                                        fontSize:
                                                                            20.sp),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // Padding(
                                                            //   padding: const EdgeInsets.all(15.0),
                                                            //   child: Text('Wind/',style: TextStyle(fontFamily: AppFonts.play,fontSize: 20.sp),),
                                                            // ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      20.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'W.Speed :${homeController.windSpeed.value}m/s',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            AppFonts
                                                                                .play,
                                                                        fontSize:
                                                                            20.sp),
                                                                  ),
                                                                  Text(
                                                                    'W.Degree :${homeController.windDeg.value}',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            AppFonts
                                                                                .play,
                                                                        fontSize:
                                                                            20.sp),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                });
                                              } else {
                                                return const Center(
                                                  child: Text(
                                                    'NO DATA',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            AppFonts.play),
                                                  ),
                                                );
                                              }
                                            },
                                            future: HomeController()
                                                .getCityWeather(),
                                          ),
                                          SizedBox(height: 25.h),

                                          /// Google Map

                                          // SizedBox(
                                          //   height: 250.h,
                                          //   width: 360.w,
                                          //   child:
                                          //   GoogleMap(
                                          //     mapType: MapType.normal,
                                          //     compassEnabled: true,
                                          //     onTap: (LatLng latLng) {
                                          //       if (_controller.isCompleted) {
                                          //         _controller.future.then((value) {
                                          //           value.animateCamera(
                                          //             CameraUpdate.newCameraPosition(
                                          //               CameraPosition(
                                          //                 target: latLng,
                                          //                 zoom: 17,
                                          //               ),
                                          //             ),
                                          //           );
                                          //           String markerName = 'marker_${markers.length}';
                                          //           Marker marker = Marker(
                                          //             markerId: MarkerId(markerName),
                                          //             position: latLng,
                                          //             infoWindow: InfoWindow(title: markerName),
                                          //           );
                                          //           setState(() => markers.add(marker));
                                          //         });
                                          //       }
                                          //     },
                                          //     markers: markers,
                                          //     zoomGesturesEnabled: false,
                                          //     myLocationButtonEnabled: true,
                                          //     myLocationEnabled: true,
                                          //     onLongPress: (LatLng latLng) {
                                          //       // String circleId = 'circles_${circles.length}';
                                          //       // Circle circle = Circle(
                                          //       //   circleId: CircleId(circleId),
                                          //       //   center: latLng,
                                          //       //   fillColor: Colors.red.shade200,
                                          //       //   strokeColor: Colors.red.shade700,
                                          //       //   radius: 30,
                                          //       //   strokeWidth: 2,
                                          //       // );
                                          //       // setState(() => circles.add(circle));
                                          //
                                          //       String polylineId = 'polyline_${polylines.length}';
                                          //       Polyline polyline = Polyline(
                                          //         polylineId: PolylineId(polylineId),
                                          //         width: 1,
                                          //         color: Colors.red,
                                          //         // jointType: JointType.bevel,
                                          //         startCap: Cap.roundCap,
                                          //         endCap: Cap.roundCap,
                                          //         points: const [
                                          //           LatLng(31.52928594907586, 34.43079695423196),
                                          //           LatLng(31.525989385117075, 34.427665218292105),
                                          //         ],
                                          //       );
                                          //       setState(() => polylines.add(polyline));
                                          //     },
                                          //     circles: circles,
                                          //     polylines: polylines,
                                          //     buildingsEnabled: true,
                                          //     zoomControlsEnabled: false,
                                          //     onMapCreated: (GoogleMapController controller) {
                                          //       _controller.complete(controller);
                                          //     },
                                          //     initialCameraPosition: const CameraPosition(
                                          //       target: LatLng(31.523441, 34.433748),
                                          //       zoom: 16.0,
                                          //     ),
                                          //   ),
                                          // ),

                                          /// Forecast 5 days
                                          // FutureBuilder<List<Forecast>>(
                                          //   future:
                                          //       homeController.getForecast(),
                                          //   builder: (context, snapshot) {
                                          //     if (snapshot.connectionState ==
                                          //         ConnectionState.waiting) {
                                          //       return const Center(
                                          //           child: SpinKitThreeInOut(
                                          //               size: 30,
                                          //               color: AppColors
                                          //                   .mainColor));
                                          //     } else if (snapshot.hasData) {
                                          //       return SizedBox(
                                          //         height: 100.h,
                                          //         child: ListView.builder(
                                          //           scrollDirection:
                                          //               Axis.horizontal,
                                          //           itemCount:
                                          //               snapshot.data!.length,
                                          //           itemBuilder:
                                          //               (context, index) {
                                          //             return Padding(
                                          //               padding:
                                          //                   EdgeInsets.only(
                                          //                       left: 8.0.w),
                                          //               child: Container(
                                          //                 height: 100.h,
                                          //                 width: 100.w,
                                          //                 decoration:
                                          //                     BoxDecoration(
                                          //                   color: Colors.indigo
                                          //                       .shade400,
                                          //                   borderRadius:
                                          //                       BorderRadius
                                          //                           .circular(
                                          //                               15.r),
                                          //                 ),
                                          //                 child: Padding(
                                          //                   padding:
                                          //                       const EdgeInsets
                                          //                           .all(8.0),
                                          //                   child: Column(
                                          //                     children: [
                                          //                       Text(
                                          //                         snapshot
                                          //                             .data![
                                          //                                 index]
                                          //                             .dtTxt,
                                          //                         style: const TextStyle(
                                          //                             fontFamily:
                                          //                                 AppFonts
                                          //                                     .play,
                                          //                             color: Colors
                                          //                                 .white),
                                          //                       ),
                                          //                       SizedBox(
                                          //                           height:
                                          //                               10.h),
                                          //                       Text(
                                          //                         snapshot
                                          //                             .data![
                                          //                                 index]
                                          //                             .main
                                          //                             .temp
                                          //                             .toString(),
                                          //                         style: TextStyle(
                                          //                             fontFamily:
                                          //                                 AppFonts
                                          //                                     .play,
                                          //                             color: Colors
                                          //                                 .white,
                                          //                             fontSize:
                                          //                                 30.sp),
                                          //                       ),
                                          //                       SizedBox(
                                          //                           height:
                                          //                               8.h),
                                          //                       Text(
                                          //                         snapshot
                                          //                             .data![
                                          //                                 index]
                                          //                             .main
                                          //                             .toString(),
                                          //                         style: const TextStyle(
                                          //                             fontFamily:
                                          //                                 AppFonts
                                          //                                     .play,
                                          //                             color: Colors
                                          //                                 .white),
                                          //                       ),
                                          //                     ],
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             );
                                          //           },
                                          //         ),
                                          //       );
                                          //     } else {
                                          //       return const Center(
                                          //           child: Text('NO DATA',
                                          //               style: TextStyle(
                                          //                   fontFamily:
                                          //                       AppFonts.play,
                                          //                   color:
                                          //                       Colors.black)));
                                          //     }
                                          //   },
                                          // ),

                                          ///
                                          SizedBox(height: 15.h),
                                          Obx(() {
                                            return IconButton(
                                              onPressed: () {
                                                ///----------------------------------------
                                                listController.favorites
                                                        .contains(homeController
                                                            .cityName.value)
                                                    ? Fluttertoast.showToast(
                                                        msg:
                                                            'City already added to list',
                                                        fontSize: 15.sp,
                                                        backgroundColor:
                                                            AppColors.blue,
                                                        textColor: Colors.black)
                                                    : listController
                                                        .addToFavorite(
                                                            homeController
                                                                .cityName
                                                                .value);

                                                //print(listController.favorites);

                                                ///--------------
                                                bool value = homeController
                                                    .isLiked.value;
                                                if (value == true) {
                                                  homeController.isLiked.value =
                                                      false;
                                                } else {
                                                  homeController.isLiked.value =
                                                      true;
                                                }
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: listController.favorites
                                                        .contains(homeController
                                                            .cityName.value)
                                                    ? Colors.red
                                                    : Colors.grey,
                                                size: 40,
                                              ),
                                            );
                                          }),
                                          SizedBox(height: 20.h),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: Center(
                                        child: Text(
                                          'NO DATA',
                                          style: TextStyle(
                                              fontFamily: AppFonts.play),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            })
                          ],
                        ),
                      ),
                    ],
                  ));
      },
    );
  }
}
