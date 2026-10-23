import 'package:flutter/material.dart';
import 'package:i_am_rich/const/theme_data.dart';
import 'package:i_am_rich/provider/darkthemeProvider.dart';
import 'package:i_am_rich/services/dark_theme_pefers.dart';
import 'package:provider/provider.dart';

import 'screens/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkthemeProvider themeChangeProvider = DarkthemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.DarkthemePrefs.getDarkTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = false;

    return MultiProvider(
      providers: [
         ChangeNotifierProvider.value(
        value: themeChangeProvider,
      ),
      ],
      child: Consumer<DarkthemeProvider>( builder: (context,themeChangeProvider,child) {
  
          return MaterialApp(
            title: 'Super Market Shop',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(false, context),
            home: Home(),
          );
        }
      ),
    );
  }
}
