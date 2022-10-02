import 'package:attendance/provider/subjectDetails.dart';
import 'package:flutter/material.dart';
import '../widgets/subjectCard.dart';

class SubjectScreen extends StatelessWidget {
  static const routeName = '/SubjectScreen';
  SubjectScreen({Key? key}) : super(key: key);
  TextEditingController totalPeriods = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final subjectD =
        ModalRoute.of(context)!.settings.arguments as SubjectDetails;
    int percentage = 0;
    if (subjectD.totalClassesTaken != 0) {
      percentage =
          ((subjectD.totalClassesAttended / subjectD.totalClassesTaken) * 100)
              .floor();
    } else {
      percentage = 100;
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(subjectD.subjectName),
            SubjectCard(percentage: percentage.toDouble() / 100),
            Text("Total Number of Periods"),
            TextField(
              enabled: false,
              controller: totalPeriods,
            )
          ],
        ),
      ),
    );
  }
}
