import 'package:flutter/cupertino.dart';
import 'package:i_am_rich/services/dark_theme_pefers.dart'; // Make sure this path is correct

class Darkthemeprovider with ChangeNotifier {
  // 1. Instantiate your preferences class
  final DarkThemePrefs _themePrefs = DarkThemePrefs(); 
  
  // 2. Rename the private variable with an underscore to avoid naming conflicts
  bool _isDarkTheme = false;

  // 3. Correct getter
  bool get isDarkTheme => _isDarkTheme;

  // 4. Correct setter with proper syntax and local storage call
  set isDarkTheme(bool value) {
    _isDarkTheme = value;
    _themePrefs.setDarkTheme(value); // Calls your asynchronous shared preferences method
    notifyListeners();               // Notifies the UI to rebuild immediately
  }
}


