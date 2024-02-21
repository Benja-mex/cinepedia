import 'package:flutter/material.dart';

class CustomButtomNavigationBar extends StatelessWidget {
  const CustomButtomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
        BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TV Shows"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
