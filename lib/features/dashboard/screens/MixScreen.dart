import 'package:flutter/material.dart';

class Mixscreen extends StatefulWidget {
  const Mixscreen({super.key});

  @override
  State<Mixscreen> createState() => _MixscreenState();
}

class _MixscreenState extends State<Mixscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Mix Screen',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
