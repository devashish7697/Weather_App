class CurrentWeatherModel {
  // Coordinates
  final double latitude;
  final double longitude;

  // City info
  final String cityName;
  final String country;

  // Weather (main block)
  final int conditionId;
  final String mainCondition;
  final String description;
  final String icon;

  // Temperature
  final double temperature;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;

  // Environment
  final int humidity;
  final int pressure;
  final int visibility;
  final int cloudiness;

  // Wind
  final double windSpeed;
  final int windDegree;

  // Sunrise / Sunset
  final int sunrise;
  final int sunset;

  CurrentWeatherModel({
    required this.latitude,
    required this.longitude,
    required this.cityName,
    required this.country,
    required this.conditionId,
    required this.mainCondition,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.pressure,
    required this.visibility,
    required this.cloudiness,
    required this.windSpeed,
    required this.windDegree,
    required this.sunrise,
    required this.sunset,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      latitude: (json["coord"]["lat"] as num).toDouble(),
      longitude: (json["coord"]["lon"] as num).toDouble(),
      cityName: json["name"],
      country: json["sys"]["country"],

      conditionId: json["weather"][0]["id"],
      mainCondition: json["weather"][0]["main"],
      description: json["weather"][0]["description"],
      icon: json["weather"][0]["icon"],

      temperature: (json["main"]["temp"] as num).toDouble(),
      feelsLike: (json["main"]["feels_like"] as num).toDouble(),
      minTemp: (json["main"]["temp_min"] as num).toDouble(),
      maxTemp: (json["main"]["temp_max"] as num).toDouble(),

      humidity: json["main"]["humidity"],
      pressure: json["main"]["pressure"],
      visibility: json["visibility"],
      cloudiness: json["clouds"]["all"],

      windSpeed: (json["wind"]["speed"] as num).toDouble(),
      windDegree: json["wind"]["deg"],

      sunrise: json["sys"]["sunrise"],
      sunset: json["sys"]["sunset"],
    );
  }
}
