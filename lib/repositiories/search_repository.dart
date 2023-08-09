import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/network/model_response/current_weather_response.dart';
import 'package:weather_app/services/network/openweatherapi_service.dart';

class SearchWeatherRepository {
  SearchWeatherRepository();

  ApiWeatherService service = ApiWeatherService();

  Future<dynamic> searchCurrentByName(String nameCity) async {
    try {
      final jsonReponse = await service.getCurrentByName(nameCity);
      return CurrentWeather.fromHttpResponse(jsonReponse);
    } catch (err) {
//todo GESTIRE errore
      throw Error();
    }
  }

   Future<dynamic> searchByName(String nameCity) async {
    try {
      final jsonReponseCurrent = await service.getCurrentByName(nameCity);
      final forecast = await service.getForecastByName(nameCity);
      // return CurrentWeather.fromHttpResponse(jsonReponseCurrent);
      return WeatherSearch(
        current: CurrentWeather.fromHttpResponse(jsonReponseCurrent),
        forecast: forecast
      );
    } catch (err) {
//todo GESTIRE errore
      throw Error();
    }
  }
}


