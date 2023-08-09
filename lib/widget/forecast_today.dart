

import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast_weather.dart';
import 'package:weather_app/pages/forecast_next_day.dart';
import 'package:weather_app/utils/utils.dart';

class ForecastToday extends StatelessWidget {
  ForecastToday({super.key, required this.nextForecast, required this.cityName});

  List<ForecastWeather> nextForecast;
  String cityName;

  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title(context),
          const SizedBox(height: 4,),
          Center(child: forecasts())
        ],
      );
    
  }

  Widget title(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Prossime 24 ore',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextButton(
          child: Text('Prossimi giorni >',
              style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          onPressed: () {
            Navigator.pushNamed(context, ForecastNextDayPage.routeName,
                arguments: {
                  'forecasts': nextForecast,
                  'cityName': cityName
                  });
          },
        ),
      ],
    );
  }

  Widget forecasts() {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      height: 120,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 12,
          );
        },
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final forecast = nextForecast[index];
          return itemForecast(forecast, context);
        },
        itemCount: 8,
      ),
    );
  }

  Widget itemForecast(ForecastWeather forecast, BuildContext context)=>Container(
    width: 68,
    padding: const EdgeInsets.all(8),
    // color: Theme.of(context).colorScheme.surface,
    decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(12)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(forecast.main.temp.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        const SizedBox(height: 4,),
        // Image.network('https://openweathermap.org/img/wn/${forecast.weather[0].icon}@2x.png', scale: 2,),
        Image.network(Utils.urlIcon(forecast.weather[0].icon), scale: 2),
        const SizedBox(height: 4,),
        Text('${DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000).hour}:00',style: TextStyle(color: Colors.grey[400], fontSize: 12))
      ],
    ),
  );  
}