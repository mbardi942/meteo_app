import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/forecast_weather.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/widget/app_bar.dart';

class ForecastNextDayPage extends StatelessWidget {
  ForecastNextDayPage({super.key});
  late List<ForecastWeather> forecasts;
  late String cityName;
  static const routeName = '/forecast_next_day';
  List<String> days = [];

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    forecasts = arguments['forecasts'] as List<ForecastWeather>;
    cityName = arguments['cityName'] as String;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        title: 'Prossimi giorni',
      ),
      body: Column(
        children: [
          showNameCity(),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 700,
                  mainAxisExtent: 80,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 3 / 2),
              itemCount: forecasts.length,
              itemBuilder: (context, index) {
                final forecast = forecasts[index];
                return itemForecstNextdays(context, forecast, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget showNameCity() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: const Alignment(0.8, 1),
          colors: Utils.gradientPrincipalCard,
          tileMode: TileMode.mirror,
        ),
      ),
      child: Center(
        child: Text(
          cityName,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget showHour(int time){
    return  Row(
              children: [
                SizedBox(
                  width: 60,
                  height: 70,
                  // color: Colors.green,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            Utils.getInitialDay(time),
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            Utils.hourFromMilli(time),
                            style: const TextStyle(fontSize: 24, color: Colors.white,fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.white,
                ),
              ],
            );
  }

  Widget itemForecstNextdays(
      BuildContext context, ForecastWeather forecast, int index) {
    return Container(
        padding: const EdgeInsets.all(8),
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: const Alignment(0.8, 1),
            colors: <Color>[
              // Color(0xFF00b6f1).withOpacity(0.8),
              // Color(0xFF30a1f7).withOpacity(0.95)
              Utils.listGradient[(index + 1) % Utils.listGradient.length][0]
                  .withOpacity(0.8),
              Utils.listGradient[(index + 1) % Utils.listGradient.length][1]
                  .withOpacity(0.95)
            ],
            tileMode: TileMode.mirror,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           showHour(forecast.dt),
          showValues(forecast),
            showTemp(forecast.main.temp),
          ],
        ));
  }

  Widget showTemp(double temp) {
    return Text(
      '${temp.toStringAsFixed(0)}°',
      style: const TextStyle(
        fontSize: 32,
        color: Colors.white,
      ),
    );
  }

  Widget showValues(ForecastWeather forecast) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Image.network(
              Utils.urlIcon(
                forecast.weather[0].icon,
              ),
              scale: 2.5,
            ),
            Text(
              Utils.capitalizeFirstLetter(forecast.weather[0].description),
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Expanded(
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.water_drop_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${forecast.main.humidity.toStringAsFixed(0)}%',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                Row(
                  children: [
                    const Text(
                      'pa',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${forecast.main.pressure}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.air_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${forecast.wind.speed.toDouble().toStringAsFixed(1)} m/s',
                      style:const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
        ),
      ],
    );
  }

  Widget itemForecstNextdaysOld(BuildContext context, ForecastWeather forecast) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 16,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: titleListTileForecast(forecast),
        leading: leadingListTileForecast(context, forecast),
        trailing: SizedBox(width: 60, child: tailingListTileForecast(forecast)),
      ),
    );
  }

  Widget tailingListTileForecast(ForecastWeather forecast) {
    return Row(
      children: [
        Text(
          '${forecast.main.temp.toStringAsFixed(1)}°',
          style: TextStyle(
            color: Utils.getColorFromTemperature(forecast.main.temp),
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.thermostat,
          color: Utils.getColorFromTemperature(forecast.main.temp),
        ),
      ],
    );
  }

  Widget leadingListTileForecast(
      BuildContext context, ForecastWeather forecast) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          DateFormat.E('it_IT')
                  .format(
                      DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000))
                  .substring(0, 3)
                  .toUpperCase() +
              Utils.hourFromMilli(forecast.dt),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget titleListTileForecast(ForecastWeather forecast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          Utils.urlIcon(
            forecast.weather[0].icon,
          ),
          scale: 3,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          forecast.weather[0].description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
