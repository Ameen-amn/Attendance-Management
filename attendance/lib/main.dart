import 'package:attendance/screens/subjectScreen.dart';
import 'package:attendance/widgets/subjectCard.dart';
import 'package:flutter/material.dart';

import './screens/login.dart';
import './screens/signUp.dart';
import './screens/subject.dart';
import './screens/classDetails.dart';
import './screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: const TextTheme(
              headline3: TextStyle(
            color: Colors.black,
            fontSize: 14,
          )),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          iconTheme: const IconThemeData(
            color: Colors.black,
            size: 24,
          )),
      routes: {
        '/': (_) => const   ClassDetails(), // HomeScreen(),
        SignUp.routeName: (_) => SignUp(),
       // ClassDetails.routeName: (_) => const ClassDetails(),
        Subject.routeName: (_) => const Subject(),
        // HomeScreen.routeName: (_) => const HomeScreen(),
        SubjectScreen.routeName:(_)=> SubjectScreen(),
      },
    );
  }
}
