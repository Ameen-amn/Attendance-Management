import 'package:flutter/material.dart';
import '../widgets/subjectCard.dart';

class SubjectScreen extends StatelessWidget {
  static const routeName = '/SubjectScreen';
  SubjectScreen({Key? key}) : super(key: key);
  TextEditingController totalPeriods = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final subject = ModalRoute.of(context)!.settings.arguments;
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
            Text(subject.toString()),
            SubjectCard(),
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
