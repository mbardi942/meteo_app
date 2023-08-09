import 'package:flutter/material.dart';

class MenuDesktop extends StatelessWidget {
  MenuDesktop({required this.onTapFavorite, required this.onTapSearch, required this.onTapSettings});

  void Function()? onTapFavorite;
  void Function()? onTapSearch;
  void Function()? onTapSettings;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Image(image: AssetImage('assets/images/icon_weather.png')),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Ricerca'),
            onTap: onTapSearch,
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('Preferiti'),
            onTap: onTapFavorite,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Impostazioni'),
            onTap: onTapSettings,
          ),
        ],
      ),
    );
  }
}