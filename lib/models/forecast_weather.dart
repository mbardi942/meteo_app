class ForecastWeather {
  int dt;
  MainWeatherData main;
  List<WeatherData> weather;
  CloudsData clouds;
  WindData wind;
  int visibility;
  double pop;
  SysData sys;
  String dtTxt;

  ForecastWeather({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
      dt: json['dt'],
      main: MainWeatherData.fromJson(json['main']),
      weather: (json['weather'] as List).map((data) => WeatherData.fromJson(data)).toList(),
      clouds: CloudsData.fromJson(json['clouds']),
      wind: WindData.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: json['pop'].toDouble(),
      sys: SysData.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
    );
  }
}

class MainWeatherData {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  MainWeatherData({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainWeatherData.fromJson(Map<String, dynamic> json) {
    return MainWeatherData(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf'].toDouble(),
    );
  }
}

class WeatherData {
  int id;
  String main;
  String description;
  String icon;

  WeatherData({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class CloudsData {
  int all;

  CloudsData({
    required this.all,
  });

  factory CloudsData.fromJson(Map<String, dynamic> json) {
    return CloudsData(
      all: json['all'],
    );
  }
}

class WindData {
  double speed;
  int deg;
  double gust;

  WindData({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory WindData.fromJson(Map<String, dynamic> json) {
    return WindData(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
      gust: json['gust'].toDouble(),
    );
  }
}

class SysData {
  String pod;

  SysData({
    required this.pod,
  });

  factory SysData.fromJson(Map<String, dynamic> json) {
    return SysData(
      pod: json['pod'],
    );
  }
}
