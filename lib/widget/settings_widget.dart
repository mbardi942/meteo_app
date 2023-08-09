import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/theme_cubit.dart';
import 'package:weather_app/widget/app_bar.dart';

class SettingsWidget extends StatefulWidget {
  SettingsWidget({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  bool darkModeEnalbed = false;

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
        title: 'Impostazioni',
        backButtonDisabled: true,
      ),
        BlocBuilder<ThemeCubit, bool>(
          builder: (context, isDarkMode) {
            return ListTile(
              title: const Text('Tema scuro'),
              trailing: Switch(
                // This bool value toggles the switch.
                value: isDarkMode,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  context.read<ThemeCubit>().toggleMode();

                  setState(() {
                    darkModeEnalbed = !darkModeEnalbed;
                  });
                },
              ),
            );
          }
        )
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: CustomAppBar(
  //       title: 'Impostazioni',
  //       backButtonDisabled: true,
  //     ),
  //     body: Column(children: [
  //       ListTile(
  //         title: Text('Tema scuro'),
  //         trailing: Switch(
  //           // This bool value toggles the switch.
  //           value: darkModeEnalbed,
  //           activeColor: Colors.red,
  //           onChanged: (bool value) {
  //             // This is called when the user toggles the switch.
  //             context.read<ThemeCubit>().toggleMode();

  //             setState(() {
  //               darkModeEnalbed = !darkModeEnalbed;
  //             });
  //           },
  //         ),
  //       )
  //     ]),
  //   );
  // }
}
