// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:i_am_rich/provider/darkthemeProvider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});




  @override
  Widget build(BuildContext context) {
  
final themeState = Provider.of<DarkthemeProvider>(context);
    print('Current theme status: ${themeState}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const SizedBox(height: 8),
            Text(
              'Tap the switch to toggle theme',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 32),
            SwitchListTile(
               title: Text(themeState.getDarkTheme ? 'Light Theme' : 'Dark Theme'),
              value: themeState.getDarkTheme ,
              secondary: Icon(themeState.getDarkTheme ?  Icons.light_mode_outlined: Icons.dark_mode_outlined ),
              onChanged: ( bool value) {
              
                themeState.setDarkTheme = value;
              
              },
              
            ),
            
          ],
        ),
      ),
    );
  }
}
