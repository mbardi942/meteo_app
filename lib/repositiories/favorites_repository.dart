import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/network/favorite_cities.dart';
import 'package:weather_app/services/network/model_response/current_weather_response.dart';
import 'package:weather_app/services/network/openweatherapi_service.dart';

class FavoritesWeatherRepository {
  FavoritesWeatherRepository({required this.favoritesService});

  //TODO da mettere su
  ApiWeatherService service = ApiWeatherService();
  // FavoriteCitiesService favoritesService = FavoriteCitiesService();
  FavoriteCitiesService favoritesService;
  late List<WeatherSearch> favoritesWeatherTemp;

  Future<List<WeatherSearch>> getWeatherFavorites() async {
    try {
      //TODO cambiare nome
      List<WeatherSearch> favoritesWeather = [];
      final favoritesCity = await favoritesService.getFavorites();
      if(favoritesCity != null ){
            for (var nameCity in favoritesCity) {
        var jsonReponseCurrent = await service.getCurrentByName(nameCity);
        var forecast = await service.getForecastByName(nameCity);
        favoritesWeather.add(WeatherSearch(
            current: CurrentWeather.fromHttpResponse(jsonReponseCurrent),
            forecast: forecast));
      }
        favoritesWeatherTemp = favoritesWeather;
          return favoritesWeather;
      }else {
        return [];
      }
      // final favoritesCity = ['Scandicci', 'Padova'];
  
  
    } catch (err) {
      throw Error();
    }
  }

  get favorites{
    return favoritesWeatherTemp;
  }

  deleteFavorite(String cityName) async {
    try{
      await favoritesService.deleteFavoriteByName(cityName);
      favoritesWeatherTemp.removeWhere((weather)=> weather.current.name == cityName);

    }catch(err){
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
          forecast: forecast);
    } catch (err) {
//todo GESTIRE errore
      throw Error();
    }
  }

  void addFavoriteCity(String newCity){
    favoritesService.addFavorites(newCity);
  }
}
