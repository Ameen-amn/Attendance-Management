import 'package:attendance/provider/subjectDetails.dart';
import 'package:attendance/widgets/homeTile.dart';
import 'package:attendance/widgets/percentage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../widgets/subjectDetailBar.dart';
import './subjectScreen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    retreiveUserDetails();
    print('lst ${classAttended.value}');
    // TODO: implement initState
    super.initState();
  }

  //demo subject list

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: ListView(
          children: [
            SubjectDetailsBar(),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 25),
              itemBuilder: (ctx, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    final _subjectsDetails =
                        await Hive.openBox<SubjectDetails>("SubjectDB");
                    final SubjectDetails passSubj = _subjectsDetails.values.firstWhere(
                        (_subjectD) =>
                            _subjectD.subjectName == subjects[index]);
                    Navigator.of(context).pushNamed(SubjectScreen.routeName,
                        arguments: SubjectDetails(
                          id: passSubj.id,
                          subjectName: subjects[index],
                          totalClassesTaken: classAttended.value[index]![1],
                          totalClassesAttended: classAttended.value[index]![0],
                        ));
                  },
                  child: HomeTile(
                      tileHead: subjects[index],
                      clss: classAttended,
                      itemIndex: index),
                  /* ListTile(
                    title: Text(subjects[index]),
                    trailing: SizedBox(
                      width: 100,
                      child: ValueListenableBuilder(
                          valueListenable: classAttended,
                          builder: (BuildContext ctx,
                              Map<int?, List<int>> classAttend, Widget? _) {
                            int percentage = 100;
                            //  subject=classAttend.keys.firstWhere((element) => subjectD,)
                            if (classAttend[index]![1] != 0) {
                              if (classAttend[index] != null) {
                                percentage = ((classAttend[index]![0] /
                                            classAttend[index]![1]) *
                                        100)
                                    .floor();
                              }
                            }

                            return PercentageCircle(
                              percentage: percentage / 100,
                              progressRadius: 25,
                              kfontSize: 14,
                              lineWidth: 5,
                            );
                          }),
                    ),
                  ), */
                ),
              ),
              itemCount: subjects.length,
            )
          ],
        ),
      ),
    ));
  }
}
