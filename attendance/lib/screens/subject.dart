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
  List<TextEditingController> _controllers = [];
  List<TextField> _fields = [];
  bool _switchValue = false;

  @override
  void initState() {
    for (final index
        in Iterable<int>.generate(userDetails['TotalNumofSubjects'])) {
      TextEditingController dynamiccontroll = new TextEditingController();
      _controllers.add(dynamiccontroll);
      _fields.add(TextField(
        controller: dynamiccontroll,
        decoration: ktextFieldDecoration,
        style: TextStyle(
          fontSize: 20,
        ),
      ));
    }
    super.initState();
  }

  @override
  void dispose() {
    for (final dynamicController in _controllers) {
      dynamicController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? dropdownValue = _controllers[0].text;
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
                  child: Row(
                    //mainAxisSize: MainAxisSize.min
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('  Upload Time Table'),
                      CupertinoSwitch(
                        value: _switchValue,
                        onChanged: (value) {
                          setState(() {
                            _switchValue = value;
                            print(_controllers.map((e) => print(e.text)));
                          });
                        },
                      ),
                    ],
                  ),
                ),
                _switchValue
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) => Column(
                          children: [
                            Text(userDetails['WorkingDays'][i]),
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (ctxx, i) => Column(
                                children: [
                                  Text('First Period'),
                                  DropdownButton<String>(
                                      value: dropdownValue,
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
                                          dropdownValue = newSubj;
                                        });
                                      })
                                ],
                              ),
                              itemCount: userDetails['NumofPeriods'],
                            )
                          ],
                        ),
                        itemCount: userDetails['WorkingDays'].length,
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
  /*  List<TextEditingController> dynamicController(int n){
   return List.generate(n, (index) {
      return // controller{$index}=TextEditingController();
    } ); 
  } */
}
