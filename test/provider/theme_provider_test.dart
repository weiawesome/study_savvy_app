import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_savvy_app/blocs/provider/theme_provider.dart';

void main() {
  group('ThemeProvider Test', () {
    test('Initial themeMode is system', () {
      final themeProvider = ThemeProvider();
      expect(themeProvider.themeMode, ThemeMode.system);
    });

    test('Setting themeMode changes themeMode', () {
      final themeProvider = ThemeProvider();
      themeProvider.themeMode = ThemeMode.light;
      expect(themeProvider.themeMode, ThemeMode.light);
    });

    test('Toggle theme changes themeMode from light to dark', () {
      final themeProvider = ThemeProvider();
      themeProvider.themeMode = ThemeMode.light;
      themeProvider.toggleTheme();
      expect(themeProvider.themeMode, ThemeMode.dark);
    });

    test('Toggle theme changes themeMode from dark to light', () {
      final themeProvider = ThemeProvider();
      themeProvider.themeMode = ThemeMode.dark;
      themeProvider.toggleTheme();
      expect(themeProvider.themeMode, ThemeMode.light);
    });

    test('Toggle theme changes themeMode from system to light', () {
      final themeProvider = ThemeProvider();
      themeProvider.themeMode = ThemeMode.system;
      themeProvider.toggleTheme();
      expect(themeProvider.themeMode, ThemeMode.light);
    });
  });
}
