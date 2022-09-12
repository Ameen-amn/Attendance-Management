import 'package:attendance/provider/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';

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

  final _form = GlobalKey<FormState>();

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

  bool hide = true;
  bool chide = true;

  bool formSave() {
    if (_form.currentState!.validate()) {
      _form.currentState?.save();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String fname = '';
    int phoneNO = 0;
    String email = '';
    String collegeName = '';
    String course = '';
    var pass;

    var password;
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
              key: _form,
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
                      onSaved: (value) {
                        fname = value!;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_phoneNoFN);
                      },
                    ),

                    //PHONE NO

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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your phone Number';
                        } else if (value.length < 10) {
                          return 'Phone no. should be 10 digicts';
                        } else if (value.length > 10) {
                          return 'Phone no. exceeds 10 digicts';
                        }
                      },
                      onSaved: (value) {
                        phoneNO = int.parse(value!);
                      },
                    ),

                    //email

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
                      validator: (value) {
                        if (!value!.contains('@')) {
                          return 'Enter a valid Email id';
                        } else if (!value.contains('.')) {
                          return 'Enter a valid Email id';
                        }
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                    ),

                    //College Name

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
                      validator: (value) {
                        if (value!.length < 2) {
                          return 'Enter your College Name Correctly';
                        } else if (value.length > 200) {
                          return 'Enter your College Name in short';
                        }
                      },
                      onSaved: (value) {
                        collegeName = value!;
                      },
                    ),

                    //Course

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
                      validator: (value) {
                        if (value!.length < 2) {
                          return 'Enter your Course Name fully';
                        } else if (value.length > 200) {
                          return 'Enter your College Name in short';
                        }
                      },
                      onSaved: (value) {
                        collegeName = value!;
                      },
                    ),

                    //Password

                    const Padding(
                      padding: EdgeInsets.only(bottom: 4, top: 16),
                      child: Text('Password'),
                    ),
                    TextFormField(
                      decoration: ktextFieldDecoration.copyWith(
                        /* suffixIconConstraints: BoxConstraints(
                            maxHeight: 40,
                            maxWidth: 40,
                          ), */
                        contentPadding: const EdgeInsets.fromLTRB(20, 0, 4, 0),
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
                          ),
                        ),
                      ),
                      focusNode: _passwoedFN,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: hide,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_cPasswordFN);
                      },
                      // ignore: curly_braces_in_flow_control_structures
                      validator: (value) {
                        password = value;
                        if (value!.length < 4) {
                          return 'Password is too short';
                        } else if (value.length > 50) {
                          return 'Password is too large';
                        }
                      },
                      onSaved: (value) {
                        pass = value!;
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
                        contentPadding: const EdgeInsets.fromLTRB(20, 0, 4, 0),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                chide = !chide;
                              });
                            },
                            icon: Iconify(
                              chide
                                  ? Fluent.eye_hide_20_filled
                                  : Fluent.eye_12_regular,
                              color: Colors.grey[600],
                            )),
                      ),
                      focusNode: _cPasswordFN,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: chide,
                      validator: (value) {
                        print(password);
                        if (value != password) {
                          return 'Passwords don\'t match';
                        }
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
                            formSave();
                            Student student = new Student(
                                name: fname,
                                email: email,
                                phoneNo: phoneNO,
                                collegeName: collegeName,
                                course: course,
                                password: pass);
                           
                            if (formSave() == true) {
                              // add student here so only after every check its uploaded
                              Navigator.of(context)
                                  .pushNamed(ClassDetails.routeName);
                            }
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
