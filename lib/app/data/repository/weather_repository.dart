import 'package:weather_app/app/api/api_response.dart';
import 'package:weather_app/app/data/model/current_weather_model.dart';
import 'package:weather_app/app/data/sources/weather_api.dart';

class WeatherRepository {

  final WeatherApi weatherApi;

  WeatherRepository( this.weatherApi);

  Future<ApiResponse<CurrentWeatherModel>> fetchCurrentWeather(
      double lat, double lon
  ){
    return weatherApi.getCurrentWeather(
        longitude: lon,
        latitude: lat
    );
  }

  Future<ApiResponse<CurrentWeatherModel>> fetchCityWeather(
      String city
      ){
    return weatherApi.getCityWeather(
        city: city,
    );
  }

}