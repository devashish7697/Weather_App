import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/api/api_client.dart';
import 'package:weather_app/app/data/repository/weather_repository.dart';
import 'package:weather_app/app/data/sources/weather_api.dart';

import 'global_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {

    print("APP BINDING RUNNING");
    final apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';
    if(apiKey.isEmpty){
      throw Exception('open Weather api key missing in .env');
    }

    Get.lazyPut<ApiClient>(() => ApiClient());

    // Weather Api depends on ApiClient
    Get.lazyPut<WeatherApi>(() => WeatherApi(
        apiClient: Get.find<ApiClient>(),
        apiKey: apiKey)
    );

    // weather Repo depends on WeatherAPi
    Get.lazyPut<WeatherRepository>(() => WeatherRepository(Get.find<WeatherApi>()));

    // must start at app starts
    Get.put(GlobalController(), permanent: true);

  }



}