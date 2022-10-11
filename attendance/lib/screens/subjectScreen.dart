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
  TextEditingController subjName = TextEditingController();
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
      percentage = 0;
    }
    _subjStatus = subjStatus(
        int.parse(userInfo[2]),
        int.parse(totalPeriods.text),
        int.parse(attendedPeriods.text),
        percentage);

    super.didChangeDependencies();
  }

  void testfun() {
    totalPeriods.text = subjectD.totalClassesTaken.toString();
    attendedPeriods.text = subjectD.totalClassesAttended.toString();
    subjName.text = subjectD.subjectName;
  }

  bool _edit = false;
  String _totalNumofPeriodshistory = '';
  String _noOfPeriodsattendedhistory = '';
  String _subjNamehistory = '';
  String _subjStatus = '';

  @override
  Widget build(BuildContext context) {
    int _totalPeriods = int.parse(totalPeriods.value.text);
    int _attendPeriods = int.parse(attendedPeriods.value.text);

    Future<void> validate() async {
      bool totalError = false;
      bool nameExists = false;
      if (subjName.text != _subjNamehistory) {
        nameExists = await nameCheck(subjName.text);
      }
      if (int.parse(attendedPeriods.value.text) != 0 &&
          int.parse(totalPeriods.value.text) != 0) {
        if (_totalPeriods >= _attendPeriods) {
          if (int.parse(totalPeriods.value.text) != 0) {
            percentage = ((int.parse(attendedPeriods.value.text) /
                        int.parse(totalPeriods.value.text)) *
                    100)
                .floor();
          }
        } else {
          warningSnackBar('You can\'t attend more than total class');
          totalError = true;
        }
      } else {
        percentage = 0;
      }
      if (nameExists) {
        //name Already Exits
        warningSnackBar("Name Already Exists");
      } else {
        if (subjectD.id != null && totalError == false) {
          updateTotalClassess(subjectD.id, int.parse(totalPeriods.value.text),
              int.parse(attendedPeriods.value.text), subjName.text);
          print(
              'gound ${totalPeriods.value.text},${attendedPeriods.value.text}');
          setState(() {
            _edit = !_edit;
          });
        } else {
          print('error found${subjectD.id}');
        }
      }
      if (totalError == false) {
        _subjStatus = subjStatus(
            int.parse(userInfo[2]),
            int.parse(totalPeriods.text),
            int.parse(attendedPeriods.text),
            percentage);
      } else {
        warningSnackBar('You can\'t attend more than total class 2');
      }
    }

    /* percentage =
        ((int.parse(attendedPeriods.text) / int.parse(totalPeriods.text)) * 100)
            .floor(); */

    return Scaffold(
      appBar: AppBar(
        title: Text(subjName.text),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (_edit == true) {
                    print('restore value');
                    totalPeriods.text = _totalNumofPeriodshistory;
                    attendedPeriods.text = _noOfPeriodsattendedhistory;
                    subjName.text = _subjNamehistory;
                    print('restored ${totalPeriods.text}');
                  } else {
                    _totalNumofPeriodshistory = totalPeriods.text;
                    _noOfPeriodsattendedhistory = attendedPeriods.text;
                    _subjNamehistory = subjName.text;
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
                child: _edit
                    ? TextField(
                        controller: subjName,
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
                      )
                    : Text(
                        subjName.text,
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
                child: SubjectCard(
                    percentage: percentage.toDouble() / 100,
                    subjStatus: _subjStatus),
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

  String subjStatus(
      int reqPercentage, int totalClass, int attendedClass, int percentage) {
    int reqclass = 0;
    if (reqPercentage == percentage) {
      return 'Reached your % attend 1 more to maintain';
    } else if (reqPercentage > percentage) {
      if (percentage == 0) {
        return 'Attend at least 1 class';
      }
      reqclass = ((totalClass * (reqPercentage / 100) - attendedClass) ~/
          (1 - (reqPercentage / 100)));

      return 'Attend $reqclass'; //classes to get your required Percentage
    } else if (reqPercentage < percentage) {
      reqclass = ((attendedClass - (totalClass * (reqPercentage / 100))) ~/
          (reqPercentage / 100));
      print('req clss $reqclass');
      reqclass = reqclass.floor();
      if (reqclass >= 1) {
        return 'You can skip $reqclass class';
      } else {
        return 'Skipping class will keep you off track';
      }
    } else {
      return 'Attend 1 more class '; //to maintain your required percentage';
    }
  }

  //Showing Snack Bar
  void warningSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: Duration(milliseconds: 2000),
      elevation: 0,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    ));
  }
}
