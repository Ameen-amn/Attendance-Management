import 'package:attendance/bottomNavBar.dart';
import 'package:attendance/provider/subjectDetails.dart';
import 'package:attendance/screens/addingNewSub.dart';
import 'package:attendance/widgets/homeTile.dart';
import 'package:attendance/widgets/percentage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../widgets/subjectDetailBar.dart';
import './subjectScreen.dart';
import '../constants.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _totalSubjects = TextEditingController();
  TextEditingController _attendancePercentage = TextEditingController();

  @override
  void didChangeDependencies() async {
    await retreiveUserDetails();
    // TODO: implement didChangeDependencies
    editingUserDetails();
    super.didChangeDependencies();
  }

  void editingUserDetails() {
    _userName.text = userInfo[0];
    _totalSubjects.text = userInfo[1];
    _attendancePercentage.text = userInfo[2];
  }

  @override
  void dispose() {
    _userName.dispose();
    _totalSubjects.dispose();
    _attendancePercentage.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  //demo subject list
  int bottomBarIndex = 0;
  bool _edit = false;
  late String _userNameHistory;
  late String _attendancePercentageHistory;
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    print('second $subjects');
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: bottomBarIndex == 0
            ? const Text(
                'Attendance Report',
                style: TextStyle(color: Colors.black54),
              )
            : const Text(
                'User Details',
                style: TextStyle(color: Colors.black54),
              ),
        backgroundColor: Colors.white,

        actions: [
          bottomBarIndex == 0
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AddingSubjScreen.routeName);
                  },
                  icon: const Icon(
                    Icons.add_rounded,
                    color: Colors.black87,
                  ))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      if (_edit == true) {
                        _userName.text = _userNameHistory;
                        _attendancePercentage.text =
                            _attendancePercentageHistory;
                      } else {
                        _userNameHistory = _userName.text;
                        _attendancePercentageHistory =
                            _attendancePercentage.text;
                      }
                      _edit = !_edit;
                    });
                  },
                  icon: Icon(
                    _edit ? Icons.close_rounded : Icons.edit_rounded,
                    color: Colors.black87,
                  ))
        ],
      ),
      bottomNavigationBar: _edit
          ? BottomNavBar(name: 'Update', action: _validateupdateUserDB)
          : BottomNavigationBar(
              currentIndex: bottomBarIndex,
              onTap: (index) {
                setState(() {
                  bottomBarIndex = index;
                });
                print(bottomBarIndex);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.file_copy_rounded), label: 'File'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ],
            ),
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: bottomBarIndex == 0
              ? ListView(
                  children: [
                    SubjectDetailsBar(),
                    //
                    /*HOME SCREEN LIST TILE*/
                    //
                    ValueListenableBuilder(
                      valueListenable: subjects,
                      builder: (BuildContext ctx, List<String> subjectList,
                          Widget? _) {
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 25),
                          itemBuilder: (ctx, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                final _subjectsDetails =
                                    await Hive.openBox<SubjectDetails>(
                                        "SubjectDB");
                                final SubjectDetails passSubj = _subjectsDetails
                                    .values
                                    .firstWhere((_subjectD) =>
                                        _subjectD.subjectName ==
                                        subjectList[index]);
                                Navigator.of(context)
                                    .pushNamed(SubjectScreen.routeName,
                                        arguments: SubjectDetails(
                                          id: passSubj.id,
                                          subjectName: subjectList[index],
                                          totalClassesTaken:
                                              classAttended.value[index]![1],
                                          totalClassesAttended:
                                              classAttended.value[index]![0],
                                        ));
                              },
                              child: HomeTile(
                                  tileHead: subjectList[index],
                                  clss: classAttended,
                                  itemIndex: index),
                            ),
                          ),
                          itemCount: subjectList.length,
                        );
                      },
                    )
                  ],
                )
              /************************ */
              //USE PROFILE SCREEN
              /************************* */
              : ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                      child: Text(' User Name'),
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
                      controller: _userName,
                    ),
                    /* const Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                      child: Text(' Total Number of Subjecs'),
                    ),
                    TextField(
                      controller: _totalSubjects,
                      decoration: ktextFieldDecoration.copyWith(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                    ), */
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                      child: Text(' Attendance Percentage required'),
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
                      controller: _attendancePercentage,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 8),
                      child: Text(" Subjects"),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                          //  color: Colors.amber,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 1,
                          )),
                      //decoration: BoxDecoration(color: Colors.grey[300]),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            horizontalTitleGap: 8,
                            tileColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            title: Text(
                              subjects.value[i],
                              softWrap: true,
                            ),
                            trailing: IconButton(
                                onPressed: () async {
                                  final _openSubj =
                                      await Hive.openBox<SubjectDetails>(
                                          "SubjectDB");
                                  final _deleteSubj = _openSubj.values
                                      .firstWhere((subject) =>
                                          subjects.value[i] ==
                                          subject.subjectName);
                                  if (_deleteSubj.id != null) {
                                    setState(() {
                                      deleteSubject(_deleteSubj.id!);
                                    });
                                  }
                                },
                                icon: const Icon(Icons.delete_rounded)),
                          ),
                        ),
                        itemCount: subjects.value.length,
                      ),
                    ),
                  ],
                )),
    ));
  }

  //USER DETAIL FUNCTIONS
  void _validateupdateUserDB() {
    if (_userName.text.isNotEmpty && _attendancePercentage.text.isNotEmpty) {
      if (int.parse(_attendancePercentage.text) >= 0 ||
          int.parse(_attendancePercentage.text) <= 100) {
        updateUserDetails(
            _userName.text, int.parse(_attendancePercentage.text));
      }
    }
  }
}
