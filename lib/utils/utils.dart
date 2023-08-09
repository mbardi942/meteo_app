import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String urlIcon(String icon) {
    return 'https://openweathermap.org/img/wn/${icon}@2x.png';
  }

  static getInitialDay(int time) {
    return capitalizeFirstLetter(DateFormat.E('it_IT')
        .format(DateTime.fromMillisecondsSinceEpoch(time * 1000))
        .substring(0, 3));
  }

  static List<Color> gradientPrincipalCard =[ const Color(0xffE263E6).withOpacity(0.8), const Color(0xff5064F1).withOpacity(0.95)];

  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  static List<List<Color>> listGradient = [
  [
    Color(0xff11ceb9), Color(0xff0ca5d1)
  ],
  [
    Color(0xfff99c36), Color(0xfffbae21)
  ],
  [
    Color(0xff8866f3), Color(0xffab5eef)
  ],
   [
    Color.fromARGB(255, 0, 202, 0), Color(0xff50C878)
  ],
];

  static String hourFromMilli(int timestamp) {
    return '${DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).hour}:00';
    // return '${DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).hour}';

  }

  static Color getColorFromTemperature(double temperature) {
    if (temperature < 0) {
      return Color(0xFF00FFFF); // Azzurro molto freddo
    } else if (temperature <= 10) {
      return Color(0xFF00BFFF); // Azzurro freddo
    } else if (temperature <= 20) {
      return Color(0xFF6495ED); // Azzurro medio
    } else if (temperature <= 25) {
      // return Color(0xFF98FB98);
      return Colors.green; // ;Verde chiaro
    } else if (temperature <= 30) {
      return Color(0xFFFFA500); // Arancione
    } else {
      return Color(0xFFFF0000); // Rosso
    }
  }
}
