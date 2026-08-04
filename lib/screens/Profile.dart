import 'package:flutter/material.dart';

void main() {
  runApp(MyCard());
}

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: Colors.yellow,

        body: SafeArea(
          child:Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              SizedBox(height: 8.0),
              Text(
                'Ganesh Veer',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                'flutter Developer'.toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5.0,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 300.0,
                child: Divider(color: Colors.deepPurpleAccent),
              ),
              SizedBox(
                width: 450.0,
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.phone, color: Colors.deepPurpleAccent),
                    title: Text(
                      '+91 9167855473',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 450.0,
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),

                  child: ListTile(
                    leading: Icon(Icons.email, color: Colors.deepPurpleAccent),
                    title: Text(
                      'ganesh.veer@cloverinfotech.com',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
