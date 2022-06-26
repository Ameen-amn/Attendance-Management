import 'package:flutter/material.dart';

class ClassDetails extends StatefulWidget {
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
          children: 
          [
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: const Text('Number of Subjects'),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Number of Subjects',
              ),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Number of Periods',
               
              ),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
