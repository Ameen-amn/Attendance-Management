import 'package:flutter/material.dart';
import './screens/login.dart';
import './screens/signUp.dart';

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
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => const LoginScreen(),
        SignUp.routeName: (_) => const SignUp(),
      },
    );
  }
}
