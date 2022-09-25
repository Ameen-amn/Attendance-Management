import 'package:attendance/provider/subjectDetails.dart';
import 'package:flutter/material.dart';

import '../widgets/subjectDetailBar.dart';
import '../widgets/percentage.dart';
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
    super.initState();
  }

  //demo subject list
  List demo = ['python', 'coa', 'cs'];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

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
                  onTap: () {
                    Navigator.of(context).pushNamed(SubjectScreen.routeName,
                        arguments: demo[index]);
                  },
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          width: 1,
                        )),
                    //   tileColor: Colors.black38,
                    title: Text(
                      demo[index],
                    ),
                    //Percentage
                    /* trailing: PercentageCircle(
                      percentage: 70,
                      outerRadius: 25,
                      innerRadius: 20,
                    ), */
                  ),
                ),
              ),
              itemCount: demo.length,
            )
          ],
        ),
      ),
    ));
  }
}
