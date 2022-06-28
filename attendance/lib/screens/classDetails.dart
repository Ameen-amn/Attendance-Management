import 'package:flutter/material.dart';

import '../constants.dart';
import './subject.dart';
import '../bottomNavBar.dart';

class ClassDetails extends StatefulWidget {
  static const routeName = '/ClassDetails';
  const ClassDetails({Key? key}) : super(key: key);

  @override
  State<ClassDetails> createState() => _ClassDetailsState();
}

class _ClassDetailsState extends State<ClassDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 45,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                bottom: 4,
              ),
              child: Text('  Number of Subjects'),
            ),
            const TextField(
              decoration: ktextFieldDecoration,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 4,
                top: 16,
              ),
              child: Text('  Number of Periods'),
            ),
            const TextField(
              decoration: ktextFieldDecoration,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 4,
                top: 16,
              ),
              child: Text('  Duration'),
            ),
            const TextField(
              decoration: ktextFieldDecoration,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 51, 0, 35),
              child: Text('Attendance Percentage to be maintained'),
            ),
            const Center(
              // %  chart

              child: CircleAvatar(
                radius: 60,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 45,
                  child: Text(
                    '100%',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text('s'))
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
        name: 'Next',
        routeName: Subject.routeName,
      ),
    );
  }
}
