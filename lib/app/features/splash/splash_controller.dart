import 'package:get/get.dart';
import 'package:weather_app/app/routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();

    Future.delayed(const Duration(seconds: 3), () {
      print("🚀 TRYING TO NAVIGATE TO: ${AppPages.HOME}");
      Get.offNamed('/home');
    });
  }

}