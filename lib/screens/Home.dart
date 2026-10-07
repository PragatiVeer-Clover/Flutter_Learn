import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/darkthemeProvider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Darkthemeprovider>(context);
    final isDark = themeProvider.isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Row(children: [
            Icon(isDark ? Icons.dark_mode : Icons.light_mode,
                color: isDark ? Colors.amber : Colors.grey),
            Switch(
              value: isDark,
              activeColor: Colors.amber,
              onChanged: (val) => themeProvider.isDarkTheme = val,
            ),
          ]),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              size: 80,
              color: isDark ? Colors.amber : Colors.blueGrey,
            ),
            const SizedBox(height: 20),
            Text(
              isDark ? 'Dark Mode' : 'Light Mode',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the switch to toggle theme',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 32),
            Switch.adaptive(
              value: isDark,
              activeColor: Colors.amber,
              onChanged: (val) => themeProvider.isDarkTheme = val,
            ),
          ],
        ),
      ),
    );
  }
}
