import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/widget/app_bar.dart';
import 'package:weather_app/widget/current_weather_widget.dart';
import 'package:weather_app/widget/forecast_today.dart';

class OverviewWeatherPage extends StatelessWidget {
  OverviewWeatherPage({super.key});

  static const routeName = '/overview_weather';

  late WeatherSearch weather;

  @override
  Widget build(BuildContext context) {
    weather = ModalRoute.of(context)?.settings.arguments as WeatherSearch;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: weather.current.name),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 12,
            ),
            CurrentWeatherWidget(
              heightFix: 350,
              weather: weather.current,
            ),
              // color: Colors.orange,
              ForecastToday(
                nextForecast: weather.forecast,
                cityName: weather.current.name,
              ),
          ],
        ),
      ),
    );
  }

  // Widget header(BuildContext context) {
  //   return SafeArea(
  //     child: Container(
  //       padding: EdgeInsets.all(4),
  //       // height: 100,
  //       width: double.infinity,
  //       // color: Colors.red,
  //       child: Stack(children: [
  //         Container(
  //           decoration: BoxDecoration(
  //               color: Theme.of(context).colorScheme.surface,
  //               shape: BoxShape.circle),
  //           child: IconButton(
  //             onPressed: () => Navigator.pop(context),
  //             icon: Center(
  //               child: Icon(
  //                 Icons.arrow_back_ios_new,
  //                 size: 16,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Align(
  //           alignment: Alignment.center,
  //           child: Text(
  //             weather.current.name,
  //             style: TextStyle(
  //                 fontWeight: FontWeight.w600,
  //                 letterSpacing: 1.2,
  //                 fontSize: 26),
  //           ),
  //         ),
  //       ]),
  //     ),
  //   );
  // }
}
