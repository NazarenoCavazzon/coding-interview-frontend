import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/theme/app_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppTheme.lightTheme);

  bool get isDarkMode => state.brightness == Brightness.dark;

  void toggleTheme() {
    emit(isDarkMode ? AppTheme.lightTheme : AppTheme.darkTheme);
  }

  void setLightTheme() {
    emit(AppTheme.lightTheme);
  }

  void setDarkTheme() {
    emit(AppTheme.darkTheme);
  }
}
