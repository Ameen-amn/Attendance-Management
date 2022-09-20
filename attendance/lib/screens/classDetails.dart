import 'package:attendance/provider/userDetails.dart';
import 'package:attendance/provider/workingDays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import './subject.dart';
import '../bottomNavBar.dart';
import '../widgets/percentage.dart';

class ClassDetails extends StatefulWidget {
  static const routeName = '/ClassDetails';
  const ClassDetails({Key? key}) : super(key: key);

  @override
  State<ClassDetails> createState() => _ClassDetailsState();
}

class _ClassDetailsState extends State<ClassDetails> {
  final fullName = TextEditingController();
  final totalSubj = TextEditingController();
  final noPeriods = TextEditingController();
  final _form = GlobalKey<FormState>();
  final List<WorkingDays> days = [
    WorkingDays(
      day: 'Monday',
    ),
    WorkingDays(
      day: 'Tuesday',
    ),
    WorkingDays(
      day: 'Wednessday',
    ),
    WorkingDays(
      day: 'Thursday',
    ),
    WorkingDays(
      day: 'Friday',
    ),
    WorkingDays(
      day: 'Saturday',
    ),
    WorkingDays(
      day: 'Sunday',
    ),
  ];
  int percentage = 75;
  Future<bool> formSave() async {
    if (_form.currentState!.validate()) {
      UserDetails _currentUser = UserDetails(
          name: fullName.text,
          totalSubject: int.parse(totalSubj.text),
          numOfPeriods: int.parse(noPeriods.text),
          attendancePercentage: percentage,
          workingDays: _workingDays);
      await classDetails('userDetails', _currentUser);
      /* await classDetails('FullName', fullName.text);
      await classDetails('TotalNumofSubjects', int.parse(totalSubj.text));
      await classDetails('NumofPeriods', int.parse(noPeriods.text));
      await classDetails('RequiredPercentage', percentage);
      await classDetails('WorkingDays', _workingDays); */
      Navigator.of(context).pushNamed(Subject.routeName);
      // _form.currentState?.save();
    }
    return true;
  }

  @override
  void dispose() {
    fullName.dispose();
    totalSubj.dispose();
    noPeriods.dispose();

    super.dispose();
  }

  final List<String> _workingDays = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 45,
        ),
        child: Form(
          key: _form,
          child: ListView(
            /* mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, */
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 4,
                ),
                child: Text(
                  '  Full Name',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              TextFormField(
                decoration: ktextFieldDecoration.copyWith(),
                controller: fullName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter full Name';
                  }
                },
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: 4,
                ),
                child: Text('  Total Number of Subjects'),
              ),
              TextFormField(
                decoration: ktextFieldDecoration,
                style: ktextStyle,
                controller: totalSubj,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null) {
                    return 'Please Enter number of periods';
                  } else if (value.isEmpty) {
                    return 'Please Enter Total Number of Subjects';
                  } else if (int.parse(value) == 0) {
                    return 'Total Number of Subjects can\'t be zero';
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0123456789]'))
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 4,
                  top: 16,
                ),
                child: Text('  Number of Periods'),
              ),
              TextFormField(
                  controller: noPeriods,
                  decoration: ktextFieldDecoration.copyWith(
                    suffixText: '/ Day',
                    suffixStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0123456789]'))
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'Please Enter number of periods';
                    } else if (value.isEmpty) {
                      return 'Please Enter number of periods';
                    } else if (int.parse(value) == 0) {
                      return ' Number of periods per day can\'t be zero';
                    }
                  },
                  style: ktextStyle),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 51, 0, 35),
                child: Text(
                  'Attendance Percentage to be maintained',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              PercentageCircle(
                percentage: percentage,
                innerRadius: 40,
                outerRadius: 50,
              ),
              Slider(
                activeColor: const Color(0XFFEB1555),
                inactiveColor: Colors.grey[350],
                value: percentage.toDouble(),
                onChanged: (newValue) {
                  setState(() {
                    percentage = newValue.toInt();
                  });
                },
                min: 0,
                max: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 4,
                  top: 16,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Text(
                    'Select the working days',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [...days.map(workingDaysCheckBox).toList()],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        name: 'Next',
        //routeName: Subject.routeName,
        action: formSave,
      ),
    );
  }

  //CheckBox for Selecting Working days
  Widget workingDaysCheckBox(WorkingDays days) => CheckboxListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      title: Text(days.day),
      value: days.state,
      onChanged: (newState) {
        setState(() {
          days.state = newState;
          if (days.state == true) {
            _workingDays.add(days.day);
            print(_workingDays);
          } else {
            _workingDays.remove(days.day);
          }
        });
      });
}
