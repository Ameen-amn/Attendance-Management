import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'userDetails.g.dart';

@HiveType(typeId: 1)
class UserDetails {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int totalSubject;
  @HiveField(2)
  final int numOfPeriods;
  @HiveField(3)
  final int attendancePercentage;
  @HiveField(4)
  final List<String> workingDays;
  UserDetails({
    required this.name,
    required this.totalSubject,
    required this.numOfPeriods,
    required this.attendancePercentage,
    required this.workingDays,
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
