import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  static const routeName = '/SignUp';
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 45,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text('Full Name'),
                ),
                const TextField(
                  decoration: InputDecoration(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 4, top: 16),
                  child: Text('Phone Number'),
                ),
                const TextField(
                  decoration: InputDecoration(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 4, top: 16),
                  child: Text('College Name'),
                ),
                const TextField(
                  decoration: InputDecoration(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
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
                const Padding(
                  padding: EdgeInsets.only(bottom: 4, top: 16),
                  child: Text('Confirm Password'),
                ),
                const TextField(
                  decoration: InputDecoration(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Sign Up'))),
                Center(
                    child: TextButton(
                        onPressed: () {}, child: const Text('Login'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
