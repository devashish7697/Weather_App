import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  // Observables
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  RxBool get isLoading => _isLoading;
  RxDouble get latitude => _latitude;
  RxDouble get longitude => _longitude;

  @override
  void onInit() {
    super.onInit();
    initLocation();
  }

  Future<void> initLocation() async {
    try {
      await _handleLocation();
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar(
        "Location Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _handleLocation() async {
    // 1. Check if GPS is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw "Please enable device location.";
    }

    // 2. Check permission
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      throw "Location permissions are permanently denied.";
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw "Location permission denied.";
      }
    }

    // 3. Get location with timeout
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).timeout(const Duration(seconds: 10), onTimeout: () {
      throw "Location request timed out. Try again.";
    });

    // 4. Save
    _latitude.value = position.latitude;
    _longitude.value = position.longitude;
  }
}
