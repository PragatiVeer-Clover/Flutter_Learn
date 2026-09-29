import 'package:flutter/material.dart';
import 'Cooking/recipes_page.dart';

void main() {
  runApp(CookingApp());
}

class CookingApp extends StatelessWidget {
  const CookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cooking App',
      theme: ThemeData.dark(),
      home: RecipesPage(),
    );
  }
}
