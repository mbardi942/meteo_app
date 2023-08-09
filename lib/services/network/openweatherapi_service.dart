import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/forecast_weather.dart';
import 'package:weather_app/services/network/model_response/current_weather_response.dart';

class ApiWeatherService {
  ApiWeatherService();

  String baseUrl = 'api.openweathermap.org';
  String appid = '6796ee66f72504e32aa4a80115559f41';
  String lang = 'it'; 
  String unit = 'metric';

  Future<dynamic> getCurrentByName(String cityName) async {
    try {
      final queryParameters = {
        'q': cityName,
        'APPID': appid,
        'lang': lang,
        'units': unit
      };
      dynamic res = await http.get(
        Uri.https(baseUrl, 'data/2.5/weather', queryParameters),
      );

      CurrentWeatherHttpResponse response = CurrentWeatherHttpResponse.fromJson(jsonDecode(res.body));
      return response;
    } catch (err) {
      throw Error();
    }
  }

  Future<dynamic> getForecastByName(String cityName) async {
    try {
      final queryParameters = {
        'q': cityName,
        'APPID': appid,
        'lang': lang,
        'units': unit
      };
      dynamic res = await http.get(
        Uri.https(baseUrl, 'data/2.5/forecast', queryParameters),
      );

      // List<ForecastWeather> response 
      List<ForecastWeather> forecast = (jsonDecode(res.body)['list'] as List).map((json){
        return ForecastWeather.fromJson(json);
      }).toList();

      return forecast;
    } catch (err) {
      throw Error();
    }
  }
}
