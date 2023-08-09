import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/favorite_city_weather.dart';
import 'package:weather_app/blocs/search_weather.dart';
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/models/forecast_weather.dart';
import 'package:weather_app/widget/current_weather_widget.dart';
import 'package:weather_app/widget/favorites_weather.dart';
import 'package:weather_app/widget/forecast_today.dart';
import 'package:weather_app/widget/settings_widget.dart';

// import 'package:intl/intl.dart';
import 'package:weather_app/widget/menu_desktop.dart';
import 'package:weather_app/widget/responsive_buiilder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  TextEditingController textController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Row(
            children: [
              if (deviceType > DeviceType.phone)
                MenuDesktop(
                  onTapFavorite: () => _onItemTapped(1),
                  onTapSearch: () => _onItemTapped(0),
                  onTapSettings: ()=> _onItemTapped(2)
                ),
              Expanded(
                child: AnimatedSwitcher(
                  duration:const  Duration(
                      milliseconds:
                          500), // Durata dell'animazione in millisecondi
                  child: home[_selectedIndex],
                ),
              )
            ],
          ),
          bottomNavigationBar: deviceType > DeviceType.phone
              ? null
              : ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16),),
                  child: bottomNavigator(),
                ),
        );
      },
    );
  }

  Widget bottomNavigator() {
    return BottomNavigationBar(
      elevation: 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Ricerca',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border_outlined),
          label: 'Preferiti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Impostazioni',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> home = [
    Column(
      children: [
        SafeArea(
          child:
           searchBar(),
        ),
        weather(),
      ],
    ),
    const FavoritesCityWeatherWidget(),
    SettingsWidget()
  ];

  Widget weather() {
    return BlocBuilder<SearchWeatherBloc, SearchWeatherState>(
        builder: (context, state) {
      if (state is SearchWeatherLoadingState) {
        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is ErrorSearchWeatherState){
        return const Expanded(
          child: Center(
            child: Text('Ops..si è verificato un errore'),
          ),
        );
      }
      if (state is SearchWeatherLoadedState) {

        CurrentWeather currentWeather = state.weather.current;
        List<ForecastWeather> forecast = state.weather.forecast;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
          mainAxisSize: MainAxisSize.min,
        
            children: [
              header(currentWeather.name),
              CurrentWeatherWidget(weather: currentWeather),
              ForecastToday(
                nextForecast: forecast,
                cityName: currentWeather.name,
              )
            ],
          ),
        );
      }
      return const Center(child: Text('Nessuna città preferita inserita'),);
    });
  }

  Widget header(String nameCity) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              nameCity,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {
                context.read<FavoriteCityWeatherBloc>().add(
                      AddFavoriteCityEvent(nameCity),
                    );
                // context.read<ThemeCubit>().toggleMode();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(milliseconds: 500),
                    backgroundColor: Colors.green,
                    content: Text('Città aggiunta ai preferiti!'),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }


  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.only(left: 32, right: 32, top: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white, fontSize: 20),
        controller: _searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              onSearch();
            },
          ),
          hintText: "Ricerca località",
        ),
        onSubmitted: (value) {
          onSearch();
        },
      ),
    );
  }

  void onSearch() {
    context.read<SearchWeatherBloc>().add(
          FetchWeatherEvent(_searchController.text.trim()),
        );
    _searchController.clear();
  }
}
