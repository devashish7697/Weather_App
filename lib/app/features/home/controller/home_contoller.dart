import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/api/api_response.dart';
import 'package:weather_app/app/core/global_controller.dart';
import 'package:weather_app/app/data/model/current_weather_model.dart';
import 'package:weather_app/app/data/repository/weather_dio_repository.dart';
import 'package:weather_app/app/data/repository/weather_repository.dart';

class HomeController extends GetxController{

    final WeatherRepository weatherRepository;
    final WeatherDioRepository weatherDioRepository;
    HomeController(this.weatherRepository, this.weatherDioRepository);

    final state = WeatherState.LOADING.obs;
    final errorMessage = ''.obs;

    // WEATHER DATA VARIABLE
    final currentWeather = Rx<CurrentWeatherModel?>(null);

    final TextEditingController searchController = TextEditingController();


    @override
    void onInit() {
      super.onInit();
      final global = Get.find<GlobalController>();

      // check if global controller fetched location
      if(global.isLoading == false){
        fetchCurrentWeather();
      }

      // if not then wait some moment and then check status , using ever worker here
      ever<bool>(global.isLoading, (loading) {
        if(loading == false){
            fetchCurrentWeather();
        }
      });
    }

    //------------------ new Dio methods -------------------------

    Future<void> CityWeather() async {
      state.value = WeatherState.LOADING;

      final response =
      await weatherDioRepository.fetchCityWeather(
          city : searchController.text
      );

      if(response.statusCode >= 200 && response.statusCode < 300 && response.data != null){
        currentWeather.value = response.data;
        state.value = WeatherState.SUCCESS;
      } else {
        errorMessage.value = response.message ?? 'unable to fetch Weather';
        state.value = WeatherState.ERROR;
      }
    }

    Future<void> fetchCurrentWeather() async {
      state.value = WeatherState.LOADING;

      // getting lat, lon from global controller
      final global = Get.find<GlobalController>();
      final lat = global.latitude.value;
      final lon = global.longitude.value;

      final response =
      await weatherDioRepository.fetchWeather(
          lat: lat.toString(),
          lon: lon.toString(),
      );
      if(response.statusCode >= 200 && response.statusCode < 300 && response.data != null){
        currentWeather.value = response.data;
        state.value = WeatherState.SUCCESS;
      } else {
        errorMessage.value = response.message ?? 'unable to fetch Weather';
        state.value = WeatherState.ERROR;
      }
    }



    // ---------------old http Methods ------------------------//


    Future<void> loadCityWeather() async {
      state.value = WeatherState.LOADING;

      final response = await weatherRepository.fetchCityWeather(searchController.text);
      if(response.statusCode >= 200 && response.statusCode < 300 && response.data != null){
        currentWeather.value = response.data;
        state.value = WeatherState.SUCCESS;
      } else {
        errorMessage.value = response.message ?? 'unable to fetch Weather';
        state.value = WeatherState.ERROR;
      }
    }

    Future<void> loadWeather() async {
      state.value = WeatherState.LOADING;

      // getting lat, lon from global controller
      final global = Get.find<GlobalController>();
      final lat = global.latitude.value;
      final lon = global.longitude.value;

      final response = await weatherRepository.fetchCurrentWeather(lat, lon);
      if(response.statusCode >= 200 && response.statusCode < 300 && response.data != null){
        currentWeather.value = response.data;
        state.value = WeatherState.SUCCESS;
      } else {
        errorMessage.value = response.message ?? 'unable to fetch Weather';
        state.value = WeatherState.ERROR;
      }
    }


    @override
    void onClose() {
      super.onClose();
      searchController.dispose();
    }

}

enum WeatherState {
  LOADING, SUCCESS, ERROR
}