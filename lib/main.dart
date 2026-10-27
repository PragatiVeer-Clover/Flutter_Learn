import 'package:flutter/material.dart';
import 'package:i_am_rich/const/theme_data.dart';
import 'package:i_am_rich/provider/darkthemeProvider.dart';
import 'package:i_am_rich/screens/bottom_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DarkthemeProvider themeChangeProvider = DarkthemeProvider();

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: themeChangeProvider,
        ),
      ],
      child: Consumer<DarkthemeProvider>(
        builder: (context, themeChangeProvider, child) {
          return MaterialApp(
            title: 'Super Market Shop',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.getDarkTheme, context),
            home: const BottomBarScreen(),
          );
        },
      ),
    );
  }
}
