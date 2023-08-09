import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/favorite_city_weather.dart';
import 'package:weather_app/models/forecast_weather.dart';
import 'package:weather_app/models/weather.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/widget/app_bar.dart';
import 'package:animate_do/animate_do.dart';

class FavoritesCityWeatherWidget extends StatefulWidget {
  const FavoritesCityWeatherWidget({super.key});

  @override
  State<FavoritesCityWeatherWidget> createState() =>
      _FavoritesCityWeatherWidgetState();
}

class _FavoritesCityWeatherWidgetState
    extends State<FavoritesCityWeatherWidget> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCityWeatherBloc, FavoriteCityWeatherState>(
        builder: (context, state) {
      if (state is FavoriteCityWeatherLoadingState) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is FavoriteCityWeatherLoadedState) {
        final favoritesWeather = state.weather;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              CustomAppBar(
                title: 'Preferiti',
                backButtonDisabled: true,
                editableIcon: isEditing ? Icons.edit_off_rounded : Icons.edit,
                onEditable: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                onRefresh: () {
                  context
                      .read<FavoriteCityWeatherBloc>()
                      .add(FetchFavoryCityWeatherEvent());
                },
              ),
              Expanded(
                child: GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      mainAxisExtent: 210,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 3 / 2),
                  itemCount: favoritesWeather.length,
                  itemBuilder: (context, index) =>
                      itemFavorite(favoritesWeather[index], context, index),
                ),
              ),
            ],
          ),
        );
      }
      return const Center(child: Text('La lista dei preferiti è vuota.. '));
    });
  }

  Widget itemForecast(ForecastWeather forecast) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
          colors: [
            Colors.transparent,
            Colors.white.withOpacity(0.15),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ' ${forecast.main.temp.toStringAsFixed(1)} °C',
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
          ),
          const SizedBox(
            height: 2,
          ),
          Image.network(
            'https://openweathermap.org/img/wn/${forecast.weather[0].icon}@2x.png',
            scale: 2,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
              '${DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000).hour}:00',
              style: TextStyle(color: Colors.grey[200], fontSize: 12))
        ],
      ),
    );
  }

// Container(
  Widget itemForecastOld(ForecastWeather forecast) {
    return Container(
      // width: 68,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ' ${forecast.main.temp.toStringAsFixed(1)} °C',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Utils.getColorFromTemperature(forecast.main.temp)),
          ),
          const SizedBox(
            height: 4,
          ),
          Image.network(
            'https://openweathermap.org/img/wn/${forecast.weather[0].icon}@2x.png',
            scale: 2,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
              '${DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000).hour}:00',
              style: TextStyle(color: Colors.grey[400], fontSize: 12))
        ],
      ),
    );
  }

  Widget itemFavorite(WeatherSearch weather, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/forecast_next_day', arguments: weather);
        Navigator.pushNamed(context, '/forecast_next_day', arguments: {
          'forecasts': weather.forecast,
          'cityName': weather.current.name
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            // height: 210,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    // offset: const Offset(0, 2),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: const Alignment(0.8, 1),
                  colors: <Color>[
                    Utils.listGradient[(index + 1) % Utils.listGradient.length]
                            [0]
                        .withOpacity(0.8),
                    Utils.listGradient[(index + 1) % Utils.listGradient.length]
                            [1]
                        .withOpacity(0.95)
                  ],
                  tileMode: TileMode.mirror,
                ),
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.surface),
            child: Column(
              children: [
                header(weather),
                Expanded(
                  child: ListView.builder(
                    // physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,

                    itemBuilder: (context, index) {
                      return itemForecast(weather.forecast[index]);
                    },
                  ),
                )
              ],
            ),
          ),
          // header(weather, context),
          if (isEditing) deleteIcon(weather)
        ]),
      ),
    );
  }

  Widget header(WeatherSearch weather) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  weather.current.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 18),
                ),
                Text(
                  '${weather.current.main.temp.toStringAsFixed(0)}°C',
                  style: const TextStyle(fontSize: 38, color: Colors.white),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/${weather.current.weather[0].icon}@2x.png',
                  scale: 1.4,
                ),
                Text(
                    Utils.capitalizeFirstLetter(
                        weather.current.weather[0].description),
                    style: const TextStyle(color: Colors.white, fontSize: 16))
              ],
            ),
          ],
        )
      ],
    );
  }

  showDialogConfirmRemove(String cityName) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminazione elemento'),
          content: const Text('Sei sicuro di voler eliminare questo elemento?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Chiudi la finestra di dialogo
              },
              child: Text(
                'Annulla',
                style: TextStyle(color: Colors.grey[300]),
              ),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<FavoriteCityWeatherBloc>()
                    .add(DeleteFavoriteCityEvent(cityName));
                Navigator.of(context).pop();
              },
              child: const Text('Conferma'),
            ),
          ],
        );
      },
    );
  }

  Widget deleteIcon(WeatherSearch weather) {
    return Positioned(
      right: -5,
      top: -6,
      child: GestureDetector(
        onTap: () => showDialogConfirmRemove(weather.current.name),
        child: Swing(
          infinite: true,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration:
                const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

Widget headerOld(weather, BuildContext context) {
  return Positioned.fill(
    top: -8,
    child: Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color.fromARGB(255, 245, 186, 90),
              Color.fromARGB(255, 225, 118, 52),
              Color.fromARGB(255, 225, 118, 52)
            ],
            // tileMode: TileMode.repeated,
          ),
        ),
        constraints: const BoxConstraints(maxWidth: 380),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
        child: AutoSizeText(
          weather.current.name,
          maxLines: 1,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
            // color: Theme.of(context).colorScheme.onPrimary
          ),
        ),
      ),
    ),
  );
}
// GridView(
//         padding: EdgeInsets.all(16),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 20,
//           crossAxisSpacing: 20,
//           childAspectRatio: 3/2
//         ),
//         // itemBuilder: (context, index) {
//         //   return  CategoryItem(category: availableCategories[index]);
//         // },
//         // itemCount: availableCategories.length,
//         children: [
//           for(var category in availableCategories)
//             CategoryItem(category: category)
//         ],
//       ),

  // Widget header(BuildContext context) {
  //   return SafeArea(
  //     child: Container(
  //       padding: EdgeInsets.only(top: 4),
  //       child: Stack(
  //         children: [
  //           Align(
  //               alignment: Alignment.center,
  //               child: Text(
  //                 'Preferiti',
  //                 style: TextStyle(
  //                     fontSize: 26,
  //                     fontWeight: FontWeight.w600,
  //                     letterSpacing: 1.2),
  //               )),
  //           Align(
  //             alignment: Alignment.centerRight,
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   color: Theme.of(context).colorScheme.surface),
  //               child: IconButton(
  //                 onPressed: () {
  //                   context
  //                       .read<FavoriteCityWeatherBloc>()
  //                       .add(FetchFavoryCityWeatherEvent());
  //                 },
  //                 icon: Icon(Icons.refresh),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
