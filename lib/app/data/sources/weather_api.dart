import 'dart:convert';

import 'package:weather_app/app/api/api_client.dart';
import 'package:weather_app/app/api/api_response.dart';
import 'package:weather_app/app/data/model/current_weather_model.dart';

class WeatherApi {

  final ApiClient apiClient;
  final String apiKey;

  WeatherApi({
  required this.apiClient,
    required this.apiKey
  });

  Future<ApiResponse<CurrentWeatherModel>> getCurrentWeather(
  {
    required double longitude,
    required double latitude,
  }) {
    print(latitude.toString());
    print(longitude.toString());
    return apiClient.get(
        path: '/data/2.5/weather',
        params: {
          "lat" : latitude.toString(),
          "lon" : longitude.toString(),
          "appid" : apiKey,
          "units" : "metric",
        },
        converter: (json) => CurrentWeatherModel.fromJson(json)
    );
  }

  Future<ApiResponse<CurrentWeatherModel>> getCityWeather(
      {
        required String city
      }) {
    return apiClient.get(
        path: '/data/2.5/weather',
        params: {
          'q' : city,
          "appid" : apiKey,
          "units" : "metric"
        },
        converter: (json) => CurrentWeatherModel.fromJson(json)
    );
  }

}