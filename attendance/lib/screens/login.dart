import 'package:attendance/screens/home.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import './signUp.dart';

import '../constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                decoration: ktextFieldDecoration,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 4, top: 16),
                child: Text('Password'),
              ),
              const TextField(
                decoration: ktextFieldDecoration,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                ),
                child: ElevatedButton(
                    style: kButtonStyle,
                    onPressed: () {
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    },
                    child: const Text('Login')),
              )),
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
      ),
    );
  }
}
