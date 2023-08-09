import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/theme_cubit.dart';
import 'package:weather_app/widget/app_bar.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkModeEnalbed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Impostazioni'
      ),
      body: Column(children: [
        ListTile(
          title: const Text('Tema scuro'),
          trailing: Switch(
            // This bool value toggles the switch.
            value: darkModeEnalbed,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              context.read<ThemeCubit>().toggleMode();

              setState(() {
                darkModeEnalbed = !darkModeEnalbed;
              });
            },
          ),
        )
      ]),
    );
  }
}
