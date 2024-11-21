import 'package:flutter/material.dart';

class Watchlistscreen extends StatefulWidget {
  const Watchlistscreen({super.key});

  @override
  State<Watchlistscreen> createState() => _WatchlistscreenState();
}

class _WatchlistscreenState extends State<Watchlistscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Watch List Screen',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
