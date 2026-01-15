import 'package:flutter/material.dart';

class ThemeManager {
  // Singleton instance
  static final ThemeManager _instance = ThemeManager._internal();
  static ThemeManager get instance => _instance;

  ThemeManager._internal();

  // Notifier for the current background image asset path
  // If null, we can use a default or the quote's own image (MIX mode)
  final ValueNotifier<String?> currentBackgroundImageNotifier = ValueNotifier<String?>(null);

  // Available themes (name, asset path)
  // Using null for 'Mix' / 'Daily' to represent the diverse default set
  final List<AppThemeOption> themes = [
    AppThemeOption(name: 'Mix', assetPath: null, icon: Icons.shuffle),
    AppThemeOption(name: 'Forest', assetPath: 'assets/images/forest_bg.png', icon: Icons.forest),
    AppThemeOption(name: 'Ocean', assetPath: 'assets/images/ocean_bg.png', icon: Icons.water),
    AppThemeOption(name: 'Sunset', assetPath: 'assets/images/sunset_bg.png', icon: Icons.wb_twilight),
    AppThemeOption(name: 'Mountain', assetPath: 'assets/images/mountain_bg.png', icon: Icons.landscape),
  ];

  void setTheme(String? assetPath) {
    currentBackgroundImageNotifier.value = assetPath;
  }
}

class AppThemeOption {
  final String name;
  final String? assetPath;
  final IconData icon;

  AppThemeOption({
    required this.name,
    required this.assetPath,
    required this.icon,
  });
}
