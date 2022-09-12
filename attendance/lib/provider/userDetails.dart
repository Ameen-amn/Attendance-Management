import 'package:flutter/material.dart';

class UserDetails {
  /* final String name;
  final int totalSubject;
  final int  */
}

Map<String, dynamic> _userDetails = {};

Map<String, dynamic> get userDetails {
  return {..._userDetails};
}

Future<void> classDetails(String userkey, dynamic details) async {
  _userDetails.addAll({userkey: details});
  //print(userDetails.values);
}
