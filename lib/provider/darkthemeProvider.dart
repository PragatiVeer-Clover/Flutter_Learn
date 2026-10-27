import 'package:flutter/cupertino.dart';
import 'package:i_am_rich/services/dark_theme_pefers.dart'; 

class DarkthemeProvider with ChangeNotifier {
  final DarkThemePrefs DarkthemePrefs = DarkThemePrefs(); 
  
  bool _isDarkTheme = false;

  bool get getDarkTheme => _isDarkTheme;

  bool get isDarkTheme => _isDarkTheme;

  set setDarkTheme(bool value) {
    _isDarkTheme = value;
    DarkthemePrefs.setDarkTheme(value); 
    notifyListeners();         
  }
}
