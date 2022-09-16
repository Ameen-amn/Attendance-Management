import 'package:flutter/material.dart';
import './percentage.dart';

/*CARD IS USED TO DISPLAY INSIDE A SUBJECT */
class SubjectCard extends StatelessWidget {
  const SubjectCard({
    Key? key,
    //required this.subjName,
  }) : super(key: key);
  //final String subjName;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
      ),
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Attendance Report'),
          PercentageCircle(percentage: 60, outerRadius: 50, innerRadius: 40),
          Text("Number of Class short with"),
        ],
      ),
    );
  }
}
