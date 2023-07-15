import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModeService{

  static const Map<ThemeMode,int> indexThemeMode={
    ThemeMode.system:0,ThemeMode.light:1,ThemeMode.dark:2
  };

  static const Map<int,ThemeMode> themeModeIndex={
    0:ThemeMode.system,1:ThemeMode.light,2:ThemeMode.dark
  };

  void setMode(ThemeMode value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('Mode', indexThemeMode[value]??0);
  }

  Future<ThemeMode> getMode() async {
    final prefs = await SharedPreferences.getInstance();
    return themeModeIndex[prefs.getInt('Mode')] ?? ThemeMode.system;
  }

}

