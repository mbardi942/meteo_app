

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/repositiories/search_repository.dart';

class SearchWeatherBloc extends Bloc<SearchWeatherEvent, SearchWeatherState> {
  SearchWeatherRepository searchRepository = SearchWeatherRepository();
  SearchWeatherBloc() : super( SearchWeatherInitState()) {
    on<FetchWeatherEvent>((event, emit) async {

       emit(SearchWeatherLoadingState());
      try{
      final weather = await searchRepository.searchByName(event.cityName);
            emit(SearchWeatherLoadedState(weather));

      }catch(err){
        emit(ErrorSearchWeatherState());
      }
    });

  }
}

//--------------EVENT
abstract class SearchWeatherEvent extends Equatable {}



class  FetchWeatherEvent extends SearchWeatherEvent {
  FetchWeatherEvent(this.cityName);

  String cityName;

   @override
  List<Object?> get props => [];
}

//--------------STATE
abstract class SearchWeatherState extends Equatable {}



class SearchWeatherInitState extends SearchWeatherState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SearchWeatherLoadingState extends SearchWeatherState {

  SearchWeatherLoadingState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchWeatherLoadedState extends SearchWeatherState {
  // final List<ProductModel> products;
  dynamic weather;
  SearchWeatherLoadedState(this.weather);
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class NoSearchWeather extends SearchWeatherState{
   NoSearchWeather();
   
     @override
     // TODO: implement props
     List<Object?> get props => throw UnimplementedError();
}

class ErrorSearchWeatherState extends SearchWeatherState {
  ErrorSearchWeatherState();
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
