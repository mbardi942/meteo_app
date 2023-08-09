

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositiories/favorites_repository.dart';

class FavoriteCityWeatherBloc extends Bloc<FavoriteCityWeatherEvent, FavoriteCityWeatherState> {
   FavoritesWeatherRepository favoritesRepository;

  FavoriteCityWeatherBloc({required this.favoritesRepository}) : super( FavoriteCityWeatherInitState()) {
    on<FetchFavoryCityWeatherEvent>((event, emit) async {
      emit(FavoriteCityWeatherLoadingState());
      List<WeatherSearch> favoriteCityWeather = await favoritesRepository.getWeatherFavorites();
      if(favoriteCityWeather.isNotEmpty){
        emit(FavoriteCityWeatherLoadedState(favoriteCityWeather));
      }else {
        emit(NoFavoriteCityWeather());
      }
    }) ;
     on<AddFavoriteCityEvent>((event, emit) async {
      favoritesRepository.addFavoriteCity(event.cityName);
      emit(FavoriteCityWeatherLoadingState());
      List<WeatherSearch> favoriteCityWeather = await favoritesRepository.getWeatherFavorites();
      emit(FavoriteCityWeatherLoadedState(favoriteCityWeather));

    }) ;
      on<DeleteFavoriteCityEvent>((event, emit) async {
      emit(FavoriteCityWeatherLoadingState());
      await favoritesRepository.deleteFavorite(event.cityName);
      List<WeatherSearch> favoriteCityWeather = favoritesRepository.favoritesWeatherTemp;
      if(favoriteCityWeather.isNotEmpty){
        emit(FavoriteCityWeatherLoadedState(favoriteCityWeather));
      }else {
        emit(NoFavoriteCityWeather());
      }

    }) ;

  }
}

//--------------EVENT
abstract class FavoriteCityWeatherEvent extends Equatable {}



class  FetchFavoryCityWeatherEvent extends FavoriteCityWeatherEvent {
  FetchFavoryCityWeatherEvent();


   @override
  List<Object?> get props => [];
}

class  AddFavoriteCityEvent extends FavoriteCityWeatherEvent {
  AddFavoriteCityEvent(this.cityName);

  String cityName;

   @override
  List<Object?> get props => [];
}

class  DeleteFavoriteCityEvent extends FavoriteCityWeatherEvent {
  DeleteFavoriteCityEvent(this.cityName);

  String cityName;

   @override
  List<Object?> get props => [];
}



//--------------STATE
abstract class FavoriteCityWeatherState extends Equatable {}



class FavoriteCityWeatherInitState extends FavoriteCityWeatherState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FavoriteCityWeatherLoadingState extends FavoriteCityWeatherState {

  FavoriteCityWeatherLoadingState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FavoriteCityWeatherLoadedState extends FavoriteCityWeatherState {
  // final List<ProductModel> products;
  List<WeatherSearch> weather;
  FavoriteCityWeatherLoadedState(this.weather);
  
  @override
  // TODO: implement props
  List<Object?> get props => [weather];
}

class NoFavoriteCityWeather extends FavoriteCityWeatherState{
   NoFavoriteCityWeather();
   
     @override
     // TODO: implement props
     List<Object?> get props => throw UnimplementedError();
}

class ErrorFavoriteCityWeatherState extends FavoriteCityWeatherState {
  ErrorFavoriteCityWeatherState();
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
