

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// class ThemeCubit extends Cubit<bool> {
//   ThemeCubit() : super(false);
//   bool isDark = false;

//   void setDarkMode() => emit(true);
//   void setLightMode() => emit(false);
//   void toggleMode(){
//     isDark = !isDark;
//     emit(isDark);
//   }
// }

class ThemeCubit extends HydratedCubit<bool> {
  ThemeCubit() : super(false);
  bool isDark = false;

  void setDarkMode() => emit(true);
  void setLightMode() => emit(false);
  void toggleMode(){
    isDark = !isDark;
    emit(isDark);
  }

  @override
  bool fromJson(Map<String, dynamic> json) => json['darkModeEnabled'] as bool;

  @override
  Map<String, bool> toJson(bool state) => { 'darkModeEnabled': state };
}