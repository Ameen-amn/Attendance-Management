import 'dart:ffi';

import 'package:attendance/bottomNavBar.dart';
import 'package:attendance/constants.dart';
import 'package:attendance/provider/subjectDetails.dart';
import 'package:flutter/material.dart';
import '../widgets/subjectCard.dart';

class SubjectScreen extends StatefulWidget {
  static const routeName = '/SubjectScreen';
  SubjectScreen({Key? key}) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  late SubjectDetails subjectD;
  @override
  TextEditingController totalPeriods = TextEditingController();

  TextEditingController attendedPeriods = TextEditingController();
  int percentage = 0;
  void didChangeDependencies() {
    subjectD = ModalRoute.of(context)!.settings.arguments as SubjectDetails;
    testfun();
    if (subjectD.totalClassesTaken != 0) {
      percentage =
          ((subjectD.totalClassesAttended / subjectD.totalClassesTaken) * 100)
              .floor();
    } else {
      percentage = 100;
    }

    super.didChangeDependencies();
  }

  int test = 0;
  int testfun() {
    test = subjectD.totalClassesAttended;
    totalPeriods.text = subjectD.totalClassesTaken.toString();
    attendedPeriods.text = subjectD.totalClassesAttended.toString();
    return test;
  }

  bool _edit = false;

  @override
  Widget build(BuildContext context) {
    /*  if (edit == false) {
      totalPeriods.text = subjectD.totalClassesTaken.toString();
      attendedPeriods.text = subjectD.totalClassesAttended.toString();
    } */
    late int _totalPeriods = int.parse(totalPeriods.text);
    late int _attendPeriods = int.parse(attendedPeriods.text);
    Future<void> validate() async {
      if (_totalPeriods >= _attendPeriods) {
        print('tot${_totalPeriods}');
        print('attper${_attendPeriods}');
        if (subjectD.id != null) {
          updateTotalClassess(subjectD.id, _totalPeriods, _attendPeriods);
        } else {
          print(subjectD.id);
        }
        setState(() {
          _edit = !_edit;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(subjectD.subjectName),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _edit = !_edit;
                  percentage;
                  print(_edit);
                });
              },
              icon: Icon(_edit ? Icons.close_rounded : Icons.edit_rounded)),
        ],
      ),
      bottomNavigationBar: _edit
          ? BottomNavBar(name: "Update", action: validate)
          : const SizedBox(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //  mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 4),
                child: Text(
                  ' Attendance Status',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 26),
                child: SubjectCard(percentage: percentage.toDouble() / 100),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text(
                  "  Number of Periods Present",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                decoration: ktextFieldDecoration.copyWith(
                    enabled: _edit,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.black54,
                          width: 2,
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
                controller: attendedPeriods,
                onChanged: (String newAttendedPeriods) {
                  attendedPeriods.text = newAttendedPeriods;
                },
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text(
                  " Total Number of Periods",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                decoration: ktextFieldDecoration.copyWith(
                    //  enabled: _edit,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.black54,
                          width: 2,
                        )),
                    border: OutlineInputBorder(
                      /*  borderSide:
                          const BorderSide(color: Colors.black87, width: 2), */
                      borderRadius: BorderRadius.circular(16),
                    )),
                enabled: _edit,
                controller: totalPeriods,
                onEditingComplete: validate,
                onChanged: (String newtotalPeriods) {
                  totalPeriods.text = newtotalPeriods;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
