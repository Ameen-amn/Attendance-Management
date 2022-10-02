import 'package:attendance/provider/subjectDetails.dart';
import 'package:attendance/provider/userDetails.dart';
import 'package:attendance/screens/initialsubject.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import './percentage.dart';

class SubjectDetailsBar extends StatefulWidget {
  const SubjectDetailsBar({
    Key? key,
    // required this.height,
  }) : super(key: key);
  // final double height;

  @override
  State<SubjectDetailsBar> createState() => _SubjectDetailsBarState();
}

class _SubjectDetailsBarState extends State<SubjectDetailsBar> {
  late String? today = weeks[0] /* 'Monday' */;
  late String? currentSubj = subjects[0];
  //final List demoWorkingdays = ['Monday', 'Tuesday'];
  final List demoSubjects = ['Python', 'SS'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.lightGreenAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DropdownButton(
                    items: /* userDetails['WorkingDays'] */
                        weeks
                            .map<DropdownMenuItem<String>>(
                                (workingDay) => DropdownMenuItem<String>(
                                      value: workingDay,
                                      child: Text(workingDay),
                                    ))
                            .toList(),
                    onChanged: (currentDay) {
                      setState(() {
                        today = currentDay.toString();
                      });
                    },
                    value: today,
                  ),
                  DropdownButton(
                    items: /* userDetails['subjects'] */
                        subjects
                            .map<DropdownMenuItem<String>>(
                                (subject) => DropdownMenuItem<String>(
                                      value: subject,
                                      child: Text(subject),
                                    ))
                            .toList(),
                    onChanged: (nowSubj) {
                      setState(() {
                        currentSubj = nowSubj.toString();
                      });
                    },
                    value: currentSubj,
                  )
                ],
              ),
              //Percentage Circle
              const SizedBox(
                  /* height: 100,
                  width: 100, */
                  child: PercentageCircle(
                progressRadius: 40,
                percentage: 0.7,
                kfontSize: 18,lineWidth: 8,
              )
              ,),
            ],
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Text("No of Periods you are short with ${3}"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final _updateSub =
                      await Hive.openBox<SubjectDetails>('SubjectDB').then(
                          (subjects) => subjects.values.firstWhere(
                              (selectSubj) =>
                                  selectSubj.subjectName == currentSubj));

                  setState(() {
                    present(_updateSub);
                  });
                },
                child: const Text(
                  'Present',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  elevation: 1,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: StadiumBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final _updateSub =
                      await Hive.openBox<SubjectDetails>('SubjectDB').then(
                          (value) => value.values.firstWhere(
                              (element) => element.subjectName == currentSubj));
                  print('wekkk${_updateSub.id}');
                  setState(() {
                    abscent(_updateSub);
                  });
                },
                child: const Text(
                  'Abscent',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  elevation: 1,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: StadiumBorder(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
