import 'package:attendance/provider/userDetails.dart';
import 'package:flutter/material.dart';

import './percentage.dart';

class SubjectDetailsBar extends StatefulWidget {
  const SubjectDetailsBar({Key? key, required this.height}) : super(key: key);
  final double height;

  @override
  State<SubjectDetailsBar> createState() => _SubjectDetailsBarState();
}

class _SubjectDetailsBarState extends State<SubjectDetailsBar> {
  late String? today = 'Monday';
  late String? currentSubj = 'Python';
  final List demoWorkingdays = ['Monday', 'Tuesday'];
  final List demoSubjects = ['Python', 'SS'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.3,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                        demoWorkingdays
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
                        demoSubjects
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
              SizedBox(
                  /* height: 100,
                  width: 100, */
                  child: PercentageCircle(percentage: 70,outerRadius: 35,innerRadius: 30,)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Text("No of Periods you are short with ${3}"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(
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
                onPressed: () {},
                child: Text(
                  'Abscent',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  elevation: 1,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
