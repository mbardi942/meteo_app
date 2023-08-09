




  import 'package:weather_app/services/network/model_response/current_weather_response.dart';

class CurrentWeather {
  List<WeatherInfo> weather;
  MainWeatherInfo main;
  int visibility;
  WindInfo wind;
  String name;

  CurrentWeather({
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.name,
  });

  

factory CurrentWeather.fromHttpResponse(CurrentWeatherHttpResponse response) {
    return CurrentWeather(
      weather: [WeatherInfo(main: response.weather[0].main, description: response.weather[0].description, icon: response.weather[0].icon)],
      main: MainWeatherInfo(feelsLike: response.main.feelsLike, humidity: response.main.humidity, pressure: response.main.pressure, temp: response.main.temp,tempMax: response.main.tempMax, tempMin: response.main.tempMin),
      visibility: response.visibility,
      wind: WindInfo(deg: response.wind.deg, speed: response.wind.speed),
      name: response.name,
    );
  }



  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      weather: (json['weather'] as List<dynamic>)
          .map((item) => WeatherInfo.fromJson(item))
          .toList(),
      main: MainWeatherInfo.fromJson(json['main']),
      visibility: json['visibility'],
      wind: WindInfo.fromJson(json['wind']),
      name: json['name'],
    );
  }
}

class WeatherInfo {
  String main;
  String description;
  String icon;

  WeatherInfo({
    required this.main,
    required this.description,
    required this.icon,

  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      icon: json['icon'],
      main: json['main'],
      description: json['description'],
    );
  }
}

class MainWeatherInfo {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  MainWeatherInfo({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory MainWeatherInfo.fromJson(Map<String, dynamic> json) {
    return MainWeatherInfo(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }
}

class WindInfo {
  double speed;
  int deg;

  WindInfo({
    required this.speed,
    required this.deg,
  });

  factory WindInfo.fromJson(Map<String, dynamic> json) {
    return WindInfo(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
    );
  }
}