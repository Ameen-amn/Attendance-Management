import 'package:attendance/provider/subjectDetails.dart';
import 'package:flutter/material.dart';
import './percentage.dart';

/*CARD IS USED TO DISPLAY INSIDE A SUBJECT */
class SubjectCard extends StatefulWidget {
  final double percentage;
  final String subjStatus;
  const SubjectCard({
    required this.percentage,
    required this.subjStatus,
    Key? key,
    //required this.subjName,
  }) : super(key: key);

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  //final String subjName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        boxShadow: const [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(2, 2),
              blurStyle: BlurStyle.solid)
        ],
        // border: Border.all(width: 1, color: Colors.black87),
        // color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
      ),
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 26, 0, 12),
            child: PercentageCircle(
              percentage: widget.percentage,
              progressRadius: 50,
              //  textPercentage: 60.toString(),
              kfontSize: 24,
              lineWidth: 10,
              animation: true,
            ),
          ),
           Padding(
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 18),
            child: Text(widget.subjStatus),
          ),
        ],
      ),
    );
  }
}
