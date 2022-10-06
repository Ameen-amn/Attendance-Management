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

  TextEditingController totalPeriods = TextEditingController();

  TextEditingController attendedPeriods = TextEditingController();
  int percentage = 0;
  @override
  void didChangeDependencies() {
    subjectD = ModalRoute.of(context)!.settings.arguments as SubjectDetails;
    testfun();

    if (int.parse(totalPeriods.value.text) != 0) {
      percentage = ((int.parse(attendedPeriods.value.text) /
                  int.parse(totalPeriods.value.text)) *
              100)
          .floor();
    } else {
      percentage = 100;
    }

    super.didChangeDependencies();
  }

  void testfun() {
    totalPeriods.text = subjectD.totalClassesTaken.toString();
    attendedPeriods.text = subjectD.totalClassesAttended.toString();
  }

  bool _edit = false;
  String _totalNumofPeriodshistory = '';
  String _noOfPeriodsattendedhistory = '';

  @override
  Widget build(BuildContext context) {
    late int _totalPeriods = int.parse(totalPeriods.text);
    late int _attendPeriods = int.parse(attendedPeriods.text);
    bool chek;
    Future<void> validate() async {
      if (_totalPeriods >= _attendPeriods) {
        if (int.parse(totalPeriods.value.text) != 0) {
          percentage = ((int.parse(attendedPeriods.value.text) /
                      int.parse(totalPeriods.value.text)) *
                  100)
              .floor();
        } else {
          percentage = 100;
        }
        print('%%% $percentage');
        print('tot${_totalPeriods}');
        print('attper${_attendPeriods}');
        if (subjectD.id != null) {
          updateTotalClassess(subjectD.id, _totalPeriods, _attendPeriods);
          setState(() {
            _edit = !_edit;
          });
         
        } else {
          print(subjectD.id);
        }
      }
    
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(subjectD.subjectName),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (_edit == true) {
                    print('restore value');
                    totalPeriods.text = _totalNumofPeriodshistory;
                    attendedPeriods.text = _noOfPeriodsattendedhistory;
                    print('restored ${totalPeriods.text}');
                  } else {
                    _totalNumofPeriodshistory = totalPeriods.text;
                    _noOfPeriodsattendedhistory = attendedPeriods.text;
                  }
                  _edit = !_edit;
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 4),
                child: Text(
                  subjectD.subjectName,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(' Attendance Status'),
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
                /* onChanged: (String newAttendedPeriods) {
                  attendedPeriods.text = newAttendedPeriods;
                }, */
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
                /* onChanged: (String newtotalPeriods) {
                  totalPeriods.text = newtotalPeriods;
                }, */
              ),
            ],
          ),
        ),
      ),
    );
    
  }
    
}
