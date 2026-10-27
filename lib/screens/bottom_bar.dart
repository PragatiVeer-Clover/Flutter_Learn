import 'package:flutter/material.dart';
import 'package:i_am_rich/provider/darkthemeProvider.dart';
import 'package:i_am_rich/screens/Home.dart';
import 'package:i_am_rich/screens/cart.dart';
import 'package:i_am_rich/screens/categories.dart';
import 'package:i_am_rich/screens/user.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Home(),
    CategorieScreen(),
    CartScreen(),
    UserScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkthemeProvider>(context);
    final bool isDark = themeState.getDarkTheme;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDark
            ? Theme.of(context).cardColor
            : Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: isDark ? Colors.lightBlue.shade200 : Colors.lightBlue.shade200,
        unselectedItemColor: isDark ? Colors.white54 : Colors.black45,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0 ? Icons.home : Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1 ? Icons.grid_view : Icons.grid_view_outlined),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 2 ? Icons.shopping_cart : Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 3 ? Icons.person : Icons.person_outline),
            label: 'Account',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
