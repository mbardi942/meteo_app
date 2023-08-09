import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:weather_app/blocs/favorite_city_weather.dart';
import 'package:weather_app/blocs/search_weather.dart';
import 'package:weather_app/blocs/theme_cubit.dart';
import 'package:weather_app/pages/forecast_next_day.dart';
import 'package:weather_app/pages/homepage.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/pages/overview_weather.dart';
import 'package:weather_app/pages/settings_page.dart';
import 'package:weather_app/repositiories/favorites_repository.dart';
import 'package:weather_app/repositiories/search_repository.dart';
import 'package:weather_app/services/network/favorite_cities.dart';
import 'package:weather_app/services/network/openweatherapi_service.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          Provider<ApiWeatherService>(
            create: (_) => ApiWeatherService(),
          ),
          Provider<FavoriteCitiesService>(
            create: (_) => FavoriteCitiesService(),
          ),
        ],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<SearchWeatherRepository>(
                create: (context) => SearchWeatherRepository()),
            RepositoryProvider<FavoritesWeatherRepository>(
                create: (context) => FavoritesWeatherRepository(
                    favoritesService: context.read())),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => ThemeCubit()),
              BlocProvider(
                create: (_) =>
                    SearchWeatherBloc()..add(FetchWeatherEvent('Milano')),
              ),
              BlocProvider(
                  create: (context) => FavoriteCityWeatherBloc(
                      favoritesRepository: context.read())
                    ..add(FetchFavoryCityWeatherEvent())),
            ],
            child: MyApp(),
          ),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final primary = Colors.purple[800];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(builder: (context, isDarkMode) {
      return _themeSelector(
        (context, mode) => MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('it')],
          title: 'Weather App',
          // theme: isDarkMode ? Theme.darkMode2() : Theme.lightMode(),
          themeMode: mode,
          theme: _theme(context),
          darkTheme: _darkTheme(context),
          home: const HomePage(),
          routes: {
            OverviewWeatherPage.routeName: (context) => OverviewWeatherPage(),
            ForecastNextDayPage.routeName: (context) => ForecastNextDayPage(),
            SettingsPage.routeName: (context) => SettingsPage(),
          },
        ),
      );
    });
  }

  Widget _themeSelector(
          Widget Function(BuildContext context, ThemeMode mode) builder) =>
      BlocBuilder<ThemeCubit, bool>(
        builder: (context, darkModeEnabled) => builder(
          context,
          darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
        ),
      );

  ThemeData _darkTheme(BuildContext context) {
    // final primary = Colors.blue[700]!;
    final primary = Colors.orange[400]!;

    final primaryColorDark = Colors.red[900]!;
    final secondaryColor = Colors.orangeAccent[100]!;
    final surfaceColor = Colors.grey[900]!;

    return ThemeData(
      primaryColor: primary,
      primaryColorDark: primaryColorDark,
      colorScheme: ColorScheme.dark(
          background: Colors.black,
          onPrimary: Colors.white,
          primary: primary,
          secondary: secondaryColor,
          surface: surfaceColor,
          onSurface: Colors.white
          // onBackground: Colors.white
          ),
      brightness: Brightness.dark,
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.pink,
          refreshBackgroundColor: Colors.purple[800],
          circularTrackColor: Colors.blue),
      inputDecorationTheme: InputDecorationTheme(
        iconColor: Colors.white,
        suffixIconColor: Colors.white,
        focusColor: Colors.red,
        hintStyle: TextStyle(color: Colors.grey[100]!, fontSize: 20),
      ),
       textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red, // Imposta il colore del cursore
        ),
    );
  }

  ThemeData _theme(BuildContext context) {
    final primary = Colors.orange[300]!;
    dynamic background = Colors.grey[200];
    return ThemeData(
      primaryColor: primary,
      primaryColorDark: primary,
      colorScheme: ColorScheme.light(
        secondary: Colors.red,
        primary: primary,
        onPrimary: Colors.white,
        background: background,
        onBackground: Colors.green,
        onSurface: Colors.black,
      ),
      
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.pink,
          refreshBackgroundColor: primary,
          circularTrackColor: Colors.blue),
           textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red, // Imposta il colore del cursore
        ),
      inputDecorationTheme: InputDecorationTheme(
        iconColor: Colors.white,
        suffixIconColor: Colors.white,
        hintStyle: TextStyle(color: Colors.grey[100]!, fontSize: 20),

        // hintStyle: TextStyle(color: Colors.grey[300]!, fontSize: 20),
      ),
    );
  }
}


// //TODO
// nei favorites si vede il bordo della car,
