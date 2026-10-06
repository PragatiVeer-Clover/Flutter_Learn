import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_am_rich/const/theme_data.dart';
import 'screens/Home.dart';
// import 'Cooking/recipes_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
 SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(new MyFirstWebApp());
}

class MyFirstWebApp extends StatelessWidget {
  const MyFirstWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = true;
    return MaterialApp(
      title: 'Grocery App',
      theme: Styles.themeData(isDarkTheme, context)
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}


