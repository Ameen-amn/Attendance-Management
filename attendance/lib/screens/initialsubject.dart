import 'package:attendance/provider/subjectDetails.dart';
import 'package:attendance/provider/timeTable.dart';
import 'package:attendance/provider/userDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import './home.dart';
import '../constants.dart';
import '../bottomNavBar.dart';
import '../provider/timeTable.dart';

class Subject extends StatefulWidget {
  static const routeName = '/Subject';
  const Subject({Key? key}) : super(key: key);

  @override
  State<Subject> createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  //list of controllers for dynamic textfields
  List<TextEditingController> _controllers = [];
  //list of dynamic textfields
  List<TextField> _fields = [];
  //cupertino switch button (Toggle button)s
  bool _switchValue = false;
  List<List<String>> _timeTableDropDownList = [];
  List<SubjectDetails> _subjectDetailsList = [];
  //late TimeTable _createTimeTableDB;
  // late SubjectDetails _subjecDetails;
  @override
  void initState() {
    //adding dynamic controllers and textfields to their respective list by
    //iterating total number of subjects
    for (final index
        in Iterable<int>.generate(userDetails['TotalNumofSubjects'])) {
      //creating dynamic controller for each textfield
      TextEditingController dynamiccontroll = TextEditingController();
      _controllers.add(dynamiccontroll);
      _fields.add(TextField(
        //assigning dynamic controller to each textfield
        controller: dynamiccontroll,
        decoration: ktextFieldDecoration,
        style: const TextStyle(
          fontSize: 20,
        ),
      ));
    }

    _timeTableDropDownList = List.generate(
        userDetails['WorkingDays'].length,
        (index) =>
            List.filled(userDetails['NumofPeriods'], _controllers[0].text));
    print('dynamic list${_timeTableDropDownList}');

    print(_timeTableDropDownList);
    super.initState();
  }

  @override
  void dispose() {
    //disposing dynamically creacted textfield
    for (final dynamicController in _controllers) {
      dynamicController.dispose();
    }
    super.dispose();
  }

  Future<void> validate() async {
    if (_controllers.length == userDetails['TotalNumofSubjects'] ||
        _controllers.isNotEmpty) {
      print('TextField is complete');
      _controllers.map((choosenSubject) => {
            //adding to subject details and subject
            _subjectDetailsList.add(
              SubjectDetails(
                subjectName: choosenSubject.text,
                totalClassesTaken: 0,
                totalClassesAttended: 0,
              ),
            ),
          });

      UserDetails _currentUser = UserDetails(
        name: userDetails['FullName'],
        totalSubject: userDetails['TotalNumofSubjects'],
        numOfPeriods: userDetails['NumofPeriods'],
        attendancePercentage: userDetails['RequiredPercentage'],
        workingDays: userDetails['WorkingDays'],
        timeTableAdded: _switchValue,
      );
      await creatingDB(_subjectDetailsList, _currentUser);
      if (_switchValue == true) {
        bool timeTableEnterdCompletey = false;
        //Checking wether all the timetable dropdown contains subjects
        for (int i = 0; i < _timeTableDropDownList.length; i++) {
          for (int j = 0; j < _timeTableDropDownList.length; j++) {
            if (_timeTableDropDownList[i][j] == '') {
              timeTableEnterdCompletey = false;
              break;
            } else {
              timeTableEnterdCompletey = true;
            }
          }
        }
        if (timeTableEnterdCompletey == true) {
          //Adding Data to timetableDB
          await timeTableDB(userDetails['WorkingDays'], _timeTableDropDownList);
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomeScreen.routeName, (Route<dynamic> route) => false);
        }
      }
      if (_switchValue == false) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName, (Route<dynamic> route) => false);
      }
    }
    retreiveUserDetails();
  }

  //dropdown  initail value
  late String? dynamicValue = _controllers[0].text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
      ),
      bottomNavigationBar: BottomNavBar(
        name: 'Submit',
        action: validate,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //List view builder for accepting subject names
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, i) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4, top: 16),
                        child: Text('  Subject ${i + 1} Name'),
                      ),
                      _fields[i]
                    ],
                  ),
                  itemCount: userDetails['TotalNumofSubjects'],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                  //Cupertion switch button (Toggle button)
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('  Upload Time Table'),
                      CupertinoSwitch(
                        value: _switchValue,
                        onChanged: (value) {
                          int check = 0;
                          setState(() {
                            for (TextEditingController loopsubject
                                in _controllers) {
                              if (loopsubject.text != '') {
                                check += 1;
                              }
                            }

                            if (check == userDetails['TotalNumofSubjects']) {
                              _switchValue = !_switchValue;
                              print('Success of adding');
                            } else {
                              print('faild');
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // if switch is true then accept timetable
                _switchValue
                    //accepting time table for each day
                    ? Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Column(
                          children: List.generate(
                            userDetails['WorkingDays'].length,
                            (day) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 30,
                                    bottom: 16,
                                  ),
                                  child: Text(
                                    userDetails['WorkingDays'][day],
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Column(
                                  children: List.generate(
                                    userDetails['NumofPeriods'],
                                    (period) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 12, 0, 8),
                                          child: Text(
                                            ' Period ${period + 1}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                  width: 3,
                                                ),
                                              ),
                                            ),
                                            //initial value
                                            hint: Text('Select Subject'),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            elevation: 3,
                                            isExpanded: true,

                                            //list of items to display in drop down

                                            items: _controllers
                                                .map<DropdownMenuItem<String>>(
                                                    (subject) =>
                                                        DropdownMenuItem<
                                                                String>(
                                                            value: subject.text,
                                                            child: Text(
                                                                subject.text)))
                                                .toList(),
                                            onChanged: (newSubj) {
                                              setState(() {
                                                _timeTableDropDownList[day]
                                                        [period] =
                                                    newSubj.toString();

                                                print(_timeTableDropDownList);
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
