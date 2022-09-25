import 'package:attendance/provider/subjectDetails.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'userDetails.g.dart';

@HiveType(typeId: 1)
class UserDetails {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int totalSubject;
  @HiveField(3)
  final int numOfPeriods;
  @HiveField(4)
  final int attendancePercentage;
  @HiveField(5)
  final List<String> workingDays;
  @HiveField(6)
  final List<SubjectDetails> subjects;
  @HiveField(7)
  final bool timeTableAdded;

  UserDetails({
    required this.name,
    required this.totalSubject,
    required this.numOfPeriods,
    required this.attendancePercentage,
    required this.workingDays,
    required this.timeTableAdded,
    required this.subjects,
    this.id,
  });
}

Map<String, dynamic> _userDetails = {};

Map<String, dynamic> get userDetails {
  return {..._userDetails};
}

Future<void> classDetails(String userkey, dynamic details) async {
  _userDetails.addAll({userkey: details});
  //print(userDetails.values);
}
