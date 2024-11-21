import 'package:flutter/material.dart';

class Accountscreen extends StatefulWidget {
  const Accountscreen({super.key});

  @override
  State<Accountscreen> createState() => _AccountscreenState();
}

class _AccountscreenState extends State<Accountscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Account Screen',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
