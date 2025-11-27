import 'package:get/get.dart';
import 'package:weather_app/app/features/splash/splash_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    print("🔥 SplashBinding executed");
    Get.put<SplashController>(SplashController());
  }

}