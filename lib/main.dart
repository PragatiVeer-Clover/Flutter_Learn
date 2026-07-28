import 'package:flutter/material.dart';
import 'widgets/buttons_section.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF9FAFB), useMaterial3: true),
      home: const ComponentLibraryDashboard()
    );
  }
}

class ComponentLibraryDashboard extends StatelessWidget {
  const ComponentLibraryDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xFFF9FAFB),
         elevation: 0,
          toolbarHeight: 100,
          title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Component library', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.black)),
            SizedBox(height: 4),
            Text('A reference sheet of common front-end controls, grouped by type.', style: TextStyle(fontSize: 13, color: Colors.black54)),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Large Screens: Use Multi-Column Matrix grid
          if (constraints.maxWidth > 900) {
            return GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.1,
              padding: const EdgeInsets.all(24),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: const [
                ButtonsSection(),
              ],
            );
            // Medium Screens: Use Single Column
          } else {
            return ListView(
              padding: const EdgeInsets.all(24),
              children: const [
                ButtonsSection(),
              ],
            );
          }
        },
      ),
    );
  }
}