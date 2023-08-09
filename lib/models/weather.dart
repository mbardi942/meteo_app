
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/models/forecast_weather.dart';

class WeatherSearch{
  CurrentWeather current;
  List<ForecastWeather> forecast;
  WeatherSearch({required this.current, required this.forecast});
}