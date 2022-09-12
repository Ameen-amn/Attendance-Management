import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final String name;
  //final String routeName;
  final Function action;
  const BottomNavBar({
    required this.name,
    // required this.routeName,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: const BoxDecoration(color: Colors.black),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        onTap:()=> action());
  }
}
