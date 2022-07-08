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
  int percentage = 50;
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
              style: ktextStyle,
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 4,
                top: 16,
              ),
              child: Text('  Number of Periods'),
            ),
            TextField(
                decoration: ktextFieldDecoration.copyWith(
                  suffixText: '/ Day',
                  suffixStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                style: ktextStyle),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 4,
                top: 16,
              ),
              child: Text(
                '  Duration',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            TextField(
              decoration: ktextFieldDecoration.copyWith(
                suffixText: ' Hour\'s',
                suffixStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 51, 0, 35),
              child: Text(
                'Attendance Percentage to be maintained',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            PercentagePieChart(percentage: percentage),
            Slider(
              activeColor: const Color(0XFFEB1555),
              inactiveColor: Colors.grey[350],
              value: percentage.toDouble(),
              onChanged: (newValue) {
                setState(() {
                  percentage = newValue.toInt();
                });
              },
              min: 0,
              max: 100,
            )
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

class PercentagePieChart extends StatelessWidget {
  const PercentagePieChart({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Center(
      // %  chart

      child: CircleAvatar(
        radius: 55,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 45,
          child: Text(
            '$percentage%',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
