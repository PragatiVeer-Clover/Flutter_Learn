import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    bool _isDarkMode = false;
    return MaterialApp(
      title: 'Grocery App',
      theme: ThemeData(
        scaffoldBackgroundColor: _isDarkMode ? Colors.deepOrange,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}


