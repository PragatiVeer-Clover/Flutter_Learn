import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'const/theme_data.dart';
import 'provider/darkthemeProvider.dart';
import 'bloc/cart_bloc.dart';
import 'grocery/grocery_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    return BlocProvider(
      create: (_) => CartBloc(),
      child: MaterialApp(
        title: 'GroceryMart',
        debugShowCheckedModeBanner: false,
        theme: Styles.themeData(themeProvider.isDarkTheme, context),
        home: const GroceryHome(),
      ),
    );
  }
}
