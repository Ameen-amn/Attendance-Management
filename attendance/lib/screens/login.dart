import 'package:flutter/material.dart';

import './signUp.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 4, top: 16),
              child: Text('Email'),
            ),
            const TextField(
              decoration: InputDecoration(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 4, top: 16),
              child: Text('Password'),
            ),
            const TextField(
              decoration: InputDecoration(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Login'))),
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUp.routeName);
                  },
                  child: const Text('Sign Up')),
            ),
          ],
        ),
      ),
    );
  }
}
