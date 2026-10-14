import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/darkthemeProvider.dart';
import 'const/theme_data.dart';
import 'employee/dashboard_home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Darkthemeprovider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Darkthemeprovider>(context);
    return MaterialApp(
      title: 'WorkSpace — Employee Dashboard',
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(themeProvider.isDarkTheme, context),
      home: const DashboardHome(),
    );
  }
}
