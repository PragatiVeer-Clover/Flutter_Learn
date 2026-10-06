import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePrefs {
  static const themeStatus = 'THEMESTATUS';

  // Save the theme preference
  Future<void> setDarkTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeStatus, isDarkTheme);
  }

  // Get the theme preference
  Future<bool> getDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? false;
  }
}
