import 'package:flutter/material.dart';
import 'package:weather_app/models/current_weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/widget/responsive_buiilder.dart';

class CurrentWeatherWidget extends StatelessWidget {
  CurrentWeatherWidget({super.key, required this.weather, this.heightFix});

  CurrentWeather weather;
  double? heightFix;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, device) {
      return Container(
        height: heightFix ??  heightFix,
        margin: device > DeviceType.phone
            ? EdgeInsets.symmetric(horizontal: 100)
            : null,
          // color: Colors.red,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                principalCardWeather(device),
                const SizedBox(
                  height: 16,
                ),
                currentParameter(context),
                const SizedBox(
                  height: 16,
                )
              ]),
      );
    });
  }

  Widget currentParameter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          itemCurrentParameter(context, Icons.air_outlined, '${weather.wind.speed} m/s',
              'Velocità Vento'),
          itemCurrentParameter(context, Icons.water_drop_outlined,
              '${weather.main.humidity}%', 'Umidità'),
          itemCurrentParameter(context, Icons.visibility_off_outlined,
              '${weather.visibility} m', 'Visibilità'),
        ],
      ),
    );
  }

  Widget itemCurrentParameter(BuildContext context, IconData icon, String value, String name) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            name,
            style: TextStyle(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget principalCardWeather(DeviceType device){
    return Container(
        // height: device > DeviceType.phone ? 200 : 140,
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            // colors: <Color>[Color(0xffE263E6), Color(0xff5064F1)],
          colors: Utils.gradientPrincipalCard,

            tileMode: TileMode.mirror,
          ),
        ),
        child: Row(
          mainAxisAlignment: device > DeviceType.phone ? MainAxisAlignment.center : MainAxisAlignment.spaceAround,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -72,
                  left: -20,
                  child: Image.network(
                      'https://openweathermap.org/img/wn/${weather.weather[0].icon}@4x.png',),
                ),
                Container(
                  // color: Colors.red,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weather.weather[0].description,
                        // 'Nubi Sparse',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.75,
                            fontSize: 20),
                      ),
                      Text(
                        showCurrentDate(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 0.75,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            if(device > DeviceType.phone) SizedBox(width: 200,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weather.main.temp.toStringAsFixed(1)}°C',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    'Percepiti ${weather.main.feelsLike}°C',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
  }

  String showCurrentDate() {
    DateTime currentDate = DateTime.now();
    String formattedDate =DateFormat('EEEE, d MMMM', 'it_IT').format(currentDate);

    return formattedDate; // Output: Sabato, 29 Luglio
  }
}
