import 'package:flutter/cupertino.dart';
//FOR CREATING AUHTENTICATION 
class Student {
  final String name;
  final String email;
  final int phoneNo;
  final String collegeName;
  final String course;
  final dynamic password;

  Student({
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.collegeName,
    required this.course,
    required this.password,
  });
}

class StudentFunctions with ChangeNotifier {
  late Map<String, Student> _students = {};

  Map<String, Student> get students {
    return {..._students};
  }

}
