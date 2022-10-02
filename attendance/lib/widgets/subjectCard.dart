import 'package:flutter/material.dart';
import './percentage.dart';

/*CARD IS USED TO DISPLAY INSIDE A SUBJECT */
class SubjectCard extends StatelessWidget {
  final double percentage;
  const SubjectCard({
    required this.percentage,
    Key? key,
    //required this.subjName,
  }) : super(key: key);
  //final String subjName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
      ),
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:  [
          Text('Attendance Report'),
          PercentageCircle(
            percentage: percentage,
            progressRadius: 50,
            //  textPercentage: 60.toString(),
            kfontSize: 18,
            lineWidth: 8,
          ),
          Text("Number of Class short with"),
        ],
      ),
    );
  }
}
