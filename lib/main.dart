import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:world_time/constant/app_colors.dart';
import 'package:world_time/constant/app_fonts.dart';
import 'package:world_time/constant/routes.dart';
import 'package:world_time/view/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tkdjhtgxsutqxainnbms.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRrZGpodGd4c3V0cXhhaW5uYm1zIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTE3NDA1NDQsImV4cCI6MjAwNzMxNjU0NH0.cWOqTh4t4gNh5JlNenxE5eKsUAC2nYicGO7Js_Yb5Mw',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                  centerTitle: true,
                  backgroundColor: AppColors.mainColor,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                      fontFamily: AppFonts.play,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp))),
          home:  const SpalshScreen(),
          getPages: AppRoutes.appRoutes(),
        );
      },
    );
  }
}
