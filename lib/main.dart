import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:IAmRichApp(),

  ));
}

class IAmRichApp extends StatelessWidget{
    const IAmRichApp({super.key});

    void _showContext(BuildContext context){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey[800],
            title: const Text(
              'The Secret Mantra',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'I am rich\nI deserv it\nI am good, healthy & successful.',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    }

    @override
    Widget build(BuildContext context){
      return  Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            title: Text('I am rich'),
            backgroundColor: Colors.blueGrey[900],
            titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.w900),
            actions: [
              IconButton(onPressed: () => _showContext(context), icon:Icon(Icons.info_outline,color: Colors.white,))
            ],
          ),
          

          body:Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      image:
                      AssetImage('images/dimond.png'),
                    height: 300,
                    loadingBuilder: (context, child, loadingProgress){
                      if (loadingProgress == null) return child;
                      return const CircularProgressIndicator(color: Colors.amber);
                    }
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: ()=> _showContext(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber, width: 2),
                        borderRadius: BorderRadius.circular(30),

                      ),
                      child: const Text(
                        'TAP TO REVEAL MANTRA',
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  )


                ],
              )
          )
      );

    }
}