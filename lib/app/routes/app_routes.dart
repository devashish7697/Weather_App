import 'package:get/get.dart';
import 'package:weather_app/app/features/home/binding/home_binding.dart';
import 'package:weather_app/app/features/home/view/home2.dart';
import 'package:weather_app/app/features/home/view/home_screen.dart';
import 'package:weather_app/app/features/splash/splash_binding.dart';
import 'package:weather_app/app/routes/app_pages.dart';

import '../features/splash/splash_screen.dart';

class AppRoutes {

  static final routes = [

    GetPage(
      name: AppPages.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
        name: AppPages.HOME,
        page: () => Home2(),
        binding: HomeBinding(),
    ),



  ];

}