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
  int globalSubIndex = 0;
  late String? today = weeks[0] /* 'Monday' */;

  late String? currentSubj = subjects.value[globalSubIndex];
  //final List demoWorkingdays = ['Monday', 'Tuesday'];
  final List demoSubjects = ['Python', 'SS'];
  @override
  Widget build(BuildContext context) {
    /* ValueListenableBuilder(
        valueListenable: subjects,
        builder: (BuildContext ctx, List<String> subjectList, Widget? _) {
          currentSubj = subjectList[globalSubIndex];
          return SizedBox();
        }); */
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(2, 2),
              blurStyle: BlurStyle.solid)
        ],
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
                  ValueListenableBuilder(
                    valueListenable: subjects,
                    builder: (BuildContext ctx, List<String> subjectList,
                        Widget? _) {
                      return DropdownButton(
                        items: /* userDetails['subjects'] */
                            subjectList
                                .map<DropdownMenuItem<String>>(
                                    (subject) => DropdownMenuItem<String>(
                                          value: subject,
                                          child: Text(subject),
                                        ))
                                .toList(),
                        onChanged: (nowSubj) {
                          setState(() {
                            globalSubIndex =
                                subjectList.indexOf(nowSubj.toString());
                            currentSubj = nowSubj.toString();
                          });
                        },
                        value: currentSubj,
                      );
                    },
                  ),
                ],
              ),
              //Percentage Circle
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: ValueListenableBuilder(
                    valueListenable: classAttended,
                    builder: (BuildContext ctx,
                        Map<int?, List<int>> classAttend, Widget? _) {
                      int percentage = 0;
                      final lastlist = classAttend.values.toList();
                      //Checking dinominator is zero or not
                      print('chacking class${classAttend[globalSubIndex]}');
                      if (lastlist[globalSubIndex][1] != 0) {
                        if (lastlist[globalSubIndex] != null) {
                          percentage = ((lastlist[globalSubIndex][0] /
                                      lastlist[globalSubIndex][1]) *
                                  100)
                              .floor();
                        }
                      }

                      return PercentageCircle(
                        percentage: percentage / 100,
                        progressRadius: 40,
                        kfontSize: 22,
                        lineWidth: 8,
                        animation: true,
                      );
                    }),
              ),
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
                    //updating dropdown and %chart automaticaly
                    /*  if (globalSubIndex < subjects.length - 1) {
                      globalSubIndex++;
                      currentSubj = subjects[globalSubIndex];
                    } else {
                      globalSubIndex = 0;
                      currentSubj = subjects[globalSubIndex];
                    } */
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
