import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/classDetails.dart';
import '../constants.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/SignUp';
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _phoneNoFN = FocusNode();

  final _collegeNameFN = FocusNode();

  final _emailFN = FocusNode();

  final _courseFN = FocusNode();

  final _passwoedFN = FocusNode();

  final _cPasswordFN = FocusNode();

  @override
  void dispose() {
    _phoneNoFN.dispose();
    _collegeNameFN.dispose();
    _emailFN.dispose();
    _courseFN.dispose();
    _passwoedFN.dispose();
    _cPasswordFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 45,
          ),
          child: Center(
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 4,
                        top: 16,
                      ),
                      child: Text(
                        'Full Name',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    TextFormField(
                      decoration: ktextFieldDecoration,
                      style: ktextStyle,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_phoneNoFN);
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4, top: 16),
                      child: Text('Phone Number'),
                    ),
                    TextFormField(
                      decoration: ktextFieldDecoration,
                      focusNode: _phoneNoFN,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFN);
                      },
                      textInputAction: TextInputAction.next,
                      style: ktextStyle,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4, top: 16),
                      child: Text('Email'),
                    ),
                    TextFormField(
                      decoration: ktextFieldDecoration,
                      focusNode: _emailFN,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_collegeNameFN);
                      },
                      textInputAction: TextInputAction.next,
                      style: ktextStyle,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4, top: 16),
                      child: Text('College Name'),
                    ),
                    TextFormField(
                      decoration: ktextFieldDecoration,
                      focusNode: _collegeNameFN,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_courseFN);
                      },
                      textInputAction: TextInputAction.next,
                      style: ktextStyle,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4, top: 16),
                      child: Text('Course'),
                    ),
                    TextFormField(
                      decoration: ktextFieldDecoration,
                      focusNode: _courseFN,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwoedFN);
                      },
                      textInputAction: TextInputAction.next,
                      style: ktextStyle,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4, top: 16),
                      child: Text('Password'),
                    ),
                    TextFormField(
                      decoration: ktextFieldDecoration,
                      focusNode: _passwoedFN,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_cPasswordFN);
                      },
                      textInputAction: TextInputAction.next,
                      style: ktextStyle,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4, top: 16),
                      child: Text('Confirm Password'),
                    ),
                    TextFormField(
                      decoration: ktextFieldDecoration.copyWith(
                        suffixIcon: Icon(Icons.lock)
                      ),
                      focusNode: _cPasswordFN,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_phoneNoFN);
                      },
                      textInputAction: TextInputAction.done,
                      style: ktextStyle,
                      
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(ClassDetails.routeName);
                          },
                          style: kButtonStyle,
                          child: const Text(
                            'Sign Up',
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Login',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
