import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:Xylophone(),

  ));
}

class Xylophone extends StatelessWidget {
  const Xylophone({super.key});


 void playSound(int soundNumber) {
    final player = AudioPlayer();
    player.play(AssetSource('note$soundNumber.wav'));
  }



  Expanded buildKey({required Color color, required int soundNumber, required String noteText}) {
    return Expanded(
      child: Container(
        width: double.infinity, 
        color: color,
        child: TextButton(
          onPressed: () => playSound(soundNumber),
          child: Text(
            noteText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Xylophone', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildKey(color: Colors.red, soundNumber: 1, noteText: 'DO'),
            buildKey(color: Colors.orange, soundNumber: 2, noteText: 'RE'),
            buildKey(color: Colors.yellow[700]!, soundNumber: 3, noteText: 'MI'),
            buildKey(color: Colors.green, soundNumber: 4, noteText: 'FA'),
            buildKey(color: Colors.teal, soundNumber: 5, noteText: 'SO'),
            buildKey(color: Colors.blue, soundNumber: 6, noteText: 'LA'),
            buildKey(color: Colors.purple, soundNumber: 7, noteText: 'TI'),
          ],
        ),
        ),
      ),
    );  
    
  }
}

