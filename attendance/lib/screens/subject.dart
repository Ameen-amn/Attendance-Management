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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
      ),
      bottomNavigationBar: const BottomNavBar(
        name: 'Submit',
        routeName: HomeScreen.routeName,
      ),
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
                      const TextField(
                        decoration: ktextFieldDecoration,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  itemCount: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 55,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('  Upload Time Table'),
                      // ToggleButtons(children: [], isSelected: [true, false])
                    ],
                  ),
                )
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
