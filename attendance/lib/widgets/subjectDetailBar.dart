import 'package:attendance/provider/subjectDetails.dart';
import 'package:attendance/provider/userDetails.dart';
import 'package:attendance/screens/initialsubject.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import './percentage.dart';

class SubjectDetailsBar extends StatefulWidget {
  final String? currentSubject;
  const SubjectDetailsBar({
    required this.currentSubject,
    Key? key,

    // required this.height,
  }) : super(key: key);
  // final double height;

  @override
  State<SubjectDetailsBar> createState() => _SubjectDetailsBarState();
}

class _SubjectDetailsBarState extends State<SubjectDetailsBar> {
  late String? today = weeks[0] /* 'Monday' */;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        boxShadow: const [
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
                  //Weeekss
                  /*  DropdownButton(
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
                  ), */
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 4),
                child: Text(
                  subjects.value[globalSubIndex],
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 26),
                ),
              ),
              //Percentage Circle
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: ValueListenableBuilder(
                    valueListenable: classAttended,
                    builder: (BuildContext ctx,
                        Map<int?, List<int>> classAttend, Widget? _) {
                      final lastlist = classAttend.values.toList();
                      //Checking dinominator is zero or not
                      print('chacking class${classAttend[globalSubIndex]}');
                      if (lastlist[globalSubIndex][1] != 0) {
                        percentage = ((lastlist[globalSubIndex][0] /
                                    lastlist[globalSubIndex][1]) *
                                100)
                            .floor();
                      } else {
                        percentage = 0;
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
          Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Text(status)

              /* ValueListenableBuilder(
              valueListenable: status,
              builder: (BuildContext ctx, String state, Widget? _) {
                
                return Text(state);
              },
            ), */
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final _updateSub = await Hive.openBox<SubjectDetails>(
                          'SubjectDB')
                      .then((subjects) => subjects.values.firstWhere(
                          (selectSubj) =>
                              selectSubj.subjectName == widget.currentSubject));

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
                    status = reqClasses(
                      percentage,
                      int.parse(userInfo[2]),
                      globalSubIndex,
                    );
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
                          (value) => value.values.firstWhere((element) =>
                              element.subjectName == widget.currentSubject));
                  print('wekkk${_updateSub.id}');
                  setState(() {
                    abscent(_updateSub);
                    status = reqClasses(
                      percentage,
                      int.parse(userInfo[2]),
                      globalSubIndex,
                    );
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
