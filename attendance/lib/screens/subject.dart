import 'package:attendance/provider/userDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './home.dart';
import '../constants.dart';
import '../bottomNavBar.dart';

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
  //cupertino switch button (Toggle button)
  bool _switchValue = false;
  List<List?> _dynamicDropdownList = [];
  @override
  void initState() {
    //adding dynamic controllers and textfields to their respective list by
    //iterating total number of subjects
    for (final index
        in Iterable<int>.generate(userDetails['TotalNumofSubjects'])) {
      //creating dynamic controller for each textfield
      TextEditingController dynamiccontroll = new TextEditingController();
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
    /* for (final index in Iterable<int>.generate(
        userDetails['NumofPeriods'] * (userDetails['WorkingDays'].length))) {
      print('sucess thikso');
      late String? dropdownValue = _controllers[0].text;

    } */
    _dynamicDropdownList = List.generate(
        userDetails['WorkingDays'].length,
        (index) =>
            List.filled(userDetails['NumofPeriods'], _controllers[0].text));
    print('dynamic list${_dynamicDropdownList}');

//OLD
    /*   _dynamicDropdownList = List.filled(userDetails['WorkingDays'].length,
        List.filled(userDetails['NumofPeriods'], 'ss')); */

    print(_dynamicDropdownList);
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
      /*  bottomNavigationBar:  BottomNavBar(
        name: 'Submit',
        routeName: HomeScreen.routeName,
        action: ,
      ), */
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 55,
                  ),
                  //Cupertion switch button (Toggle button)
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('  Upload Time Table'),
                      CupertinoSwitch(
                        value: _switchValue,
                        onChanged: (value) {
                          setState(() {
                            _switchValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // if switch is true then accept timetable
                _switchValue
                    //accepting time table for each day
                    ? ListView(
                        shrinkWrap: true,
                        children: List.generate(
                          userDetails['WorkingDays'].length,
                          (day) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                  userDetails['NumofPeriods'],
                                  (period) => Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 8),
                                        child: Text(
                                          'Period ${period + 1}',
                                          style: TextStyle(
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
                                                      DropdownMenuItem<String>(
                                                          value: subject.text,
                                                          child: Text(
                                                              subject.text)))
                                              .toList(),
                                          onChanged: (newSubj) {
                                            setState(() {
                                              _dynamicDropdownList[day]![
                                                  period] = newSubj;

                                              print(_dynamicDropdownList);
                                            });
                                          }),
                                    ],
                                  ),

                                  /*  DropdownButton(
                                      value: _dynamicDropdownList[index]![i],
                                      items: _controllers
                                          .map<DropdownMenuItem<String>>(
                                              (subject) => DropdownMenuItem<String>(
                                                  value: subject.text,
                                                  child: Text(subject.text)))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _dynamicDropdownList[index]![i] = value;
                                        });
                                        print(_dynamicDropdownList);
                                      }), */
                                ),
                              ),
                            ],
                          ),
                        ),
                        //test2
                        //
                        /*   for (var days = 0;
                              days < userDetails['WorkingDays'].length;
                              days++)
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: userDetails['NumofPeriods'],
                              itemBuilder: ((context, index) =>
                            
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
                                      hint: Text('helo'),
                                      /*  value: _dynamicDropdownList[index]
                                                  ?[i] ??
                                              '', */

                                      borderRadius: BorderRadius.circular(8),
                                      elevation: 3,
                                      isExpanded: true,

                                      //list of items to display in drop down

                                      items: _controllers
                                          .map<DropdownMenuItem<String>>(
                                              (subject) =>
                                                  DropdownMenuItem<String>(
                                                      value: subject.text,
                                                      child:
                                                          Text(subject.text)))
                                          .toList(),
                                      onChanged: (newSubj) {
                                        setState(() {
                                          _dynamicDropdownList[days]![index] =
                                              newSubj;

                                          print(_dynamicDropdownList);
                                        });
                                      })),
                            ), */
                        //
                        ///tes2 end
                        /////
                        /*   for (int days = 0;
                              days < userDetails['WorkingDays'].length;
                              days++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  child: Text(
                                    ' ${userDetails['WorkingDays'][days]}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                for (int periods = 0;
                                    periods < userDetails['NumofPeriods'];
                                    periods++)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' ${periods + 1} Periods',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 4, 0, 16),
                                        child: SizedBox(
                                          height: 55,
                                          child: DropdownButtonFormField<
                                                  String>(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    width: 3,
                                                  ),
                                                ),
                                              ),
                                              //initial value
                                              hint: const Text(
                                                  'Select the Subject'),
                                              /*  value: _dynamicDropdownList[index]
                                                      ?[i] ??
                                                  '', */

                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              elevation: 3,
                                              isExpanded: true,

                                              //list of items to display in drop down

                                              items: _controllers
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((subject) =>
                                                      DropdownMenuItem<String>(
                                                          value: subject.text,
                                                          child: Text(
                                                              subject.text)))
                                                  .toList(),
                                              onChanged: (newSubj) {
                                                setState(() {
                                                  _dynamicDropdownList[days]![
                                                      periods] = newSubj;

                                                  print(_dynamicDropdownList);
                                                });
                                              }),
                                        ),
                                      )
                                    ],
                                  ),
                                //new
                              ],
                            ) */

                        //new
                        //
                        /* ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    userDetails['WorkingDays'][index],
                                    //style: ktextStyle,
                                  ),
                                ),
                                //Each period of a day
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (ctxx, i) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 8),
                                        child: Text(
                                          '${i + 1} Period',
                                          style: ktextStyle,
                                        ),
                                      ),
                                      //dropdown for selecting each subject
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
                                        hint: Text(
                                            index.toString() + i.toString()),
                                        /*  value: _dynamicDropdownList[index]
                                                  ?[i] ??
                                              '', */

                                        borderRadius: BorderRadius.circular(8),
                                        elevation: 3,
                                        isExpanded: true,

                                        //list of items to display in drop down

                                        items: _controllers
                                            .map<DropdownMenuItem<String>>(
                                                (subject) =>
                                                    DropdownMenuItem<String>(
                                                        value: subject.text,
                                                        child:
                                                            Text(subject.text)))
                                            .toList(),
                                        onChanged: (newSubj) {
                                          setState(() {
                                            _dynamicDropdownList[index]![i] =
                                                newSubj;
                                            print(_dynamicDropdownList[index]![
                                                i]);
                                          });
                                        },
                                        /*  */
                                      ),
                                    ],
                                  ),
                                  itemCount: userDetails['NumofPeriods'],
                                )
                              ],
                            ),
                            itemCount: userDetails['WorkingDays'].length,
                          ), */
                        //test3  ],
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
