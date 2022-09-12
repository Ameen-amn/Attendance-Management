import 'package:attendance/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';

import '../constants.dart';
import './signUp.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hide = true;
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
              TextField(
                decoration: ktextFieldDecoration.copyWith(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hide = !hide;
                        });
                      },
                      icon: Iconify(
                        hide
                            ? Fluent.eye_hide_20_filled
                            : Fluent.eye_12_regular,
                        color: Colors.grey[600],
                      )),
                ),
                obscureText: hide,
                style: ktextStyle,
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
