import 'package:get/get.dart';
import 'package:weather_app/app/core/global_controller.dart';
import 'package:weather_app/app/data/repository/weather_dio_repository.dart';
import 'package:weather_app/app/data/repository/weather_repository.dart';
import 'package:weather_app/app/features/home/controller/home_contoller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
        () => HomeController(Get.find<WeatherRepository>(), Get.find<WeatherDioRepository>())
    );
  }


}