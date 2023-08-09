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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");
  
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
          debugShowCheckedModeBanner: false,
          supportedLocales: [Locale('it')],
          title: 'Weather App',
          // theme: isDarkMode ? Theme.darkMode2() : Theme.lightMode(),
          themeMode: mode,
          theme: ThemeLight(context),
          darkTheme: DarkTheme(context),
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

  
}


// //TODO
// nei favorites si vede il bordo della car,
