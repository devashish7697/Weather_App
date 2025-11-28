import 'dart:convert';

import 'package:weather_app/app/api/api_response.dart';
import 'package:weather_app/app/data/model/current_weather_model.dart';
import 'package:weather_app/app/network/dio_api.dart';

class WeatherDioRepository {

  final DioApi dio;

  WeatherDioRepository(this.dio){
    print('Weather Dio Repo Created');
  }

  Future<ApiResponse<CurrentWeatherModel>> fetchWeather({
    required String lat, required String lon
  }) async {

    final response = await dio.get(
      queryParams: {
        'lat' : lat,
        'lon' : lon,
      },
      uri: '/data/2.5/weather',
    );

    if(!response.success) {
      return ApiResponse.error(
        response.message ?? 'error in fetching weather method'
      );
    }

    try {
      final model = CurrentWeatherModel.fromJson(response.data as Map<String,dynamic>);
      return ApiResponse.success(
        model,
        statusCode: response.statusCode,
        message: response.message ?? 'Successfuly Fetched Current Weather Data'
      );
    } catch (e){
      return ApiResponse.error(
        'Parsing Error',
        statusCode: 500
      );
    }
  }

  Future<ApiResponse<CurrentWeatherModel>> fetchCityWeather({
    required String city,
  }) async {

    final response = await dio.get(
        queryParams: {
          'q' : city,
        },
      uri: '/data/2.5/weather'
    );

    if(!response.success){
      return ApiResponse.error(
        response.message ?? 'error in fetching weather method'
      );
    }

    try{
      final model = CurrentWeatherModel.fromJson(response.data as Map<String,dynamic>);
      return ApiResponse.success(
        model,
        statusCode: response.statusCode,
        message: response.message ?? 'Fetched City Weather Succesfully',
      );
    } catch (e) {
      return ApiResponse.error(
        response.error ?? 'error in parsing Weaher model',
        statusCode: 500
      );
    }


  }

}