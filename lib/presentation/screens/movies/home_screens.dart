import 'package:flutter/material.dart';
import '../../../config/constants/environament.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "Home_screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Environment.thenMovieDbKey),
      ),
    );
  }
}
