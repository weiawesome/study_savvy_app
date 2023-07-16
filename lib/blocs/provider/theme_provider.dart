import 'package:flutter/material.dart';
import 'package:study_savvy_app/services/utils/mode_storage.dart';

class ThemeProvider extends ChangeNotifier {
  final ModeService modeService=ModeService();

  ThemeMode _themeMode=ThemeMode.system;

  ThemeProvider() {
    _loadModePreference();
  }
  void _loadModePreference() async {
    _themeMode=await modeService.getMode();
    notifyListeners();
  }
  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
    modeService.setMode(themeMode);
  }
  void toggleTheme() {
    _themeMode = (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
