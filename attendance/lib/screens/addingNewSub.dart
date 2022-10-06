import 'package:attendance/bottomNavBar.dart';
import 'package:attendance/provider/subjectDetails.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class AddingSubjScreen extends StatefulWidget {
  static const routeName = '/AddingSubjScreen';
  const AddingSubjScreen({Key? key}) : super(key: key);

  @override
  State<AddingSubjScreen> createState() => _AddingSubjScreenState();
}

class _AddingSubjScreenState extends State<AddingSubjScreen> {
  TextEditingController _newSubjName = TextEditingController();
  TextEditingController _classAttended = TextEditingController()..text = '0';
  TextEditingController _totalClasses = TextEditingController()..text = '0';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavBar(
        name: 'Add',
        action: _addNewSubject,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
              child: Text(' New Subject Name'),
            ),
            TextField(
              decoration: ktextFieldDecoration,
              controller: _newSubjName,
              onChanged: (String newSubjName) {
                //  _newSubjName.text = newSubjName;
              },
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
              child: Text(' Number of classes you were present'),
            ),
            TextField(
              decoration: ktextFieldDecoration.copyWith(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              )),
              controller: _classAttended,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
              child: Text(' Total Classes taken'),
            ),
            TextField(
              decoration: ktextFieldDecoration.copyWith(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              )),
              controller: _totalClasses,
            ),
          ],
        ),
      ),
    ));
  }

  void _addNewSubject() {
    if (_newSubjName.text.isNotEmpty &&
        _classAttended.text.isNotEmpty &&
        _totalClasses.text.isNotEmpty) {
      if (int.parse(_totalClasses.text) >= int.parse(_classAttended.text)) {
        addNewSubject(_newSubjName.text, int.parse(_classAttended.text),
            int.parse(_totalClasses.text));
        Navigator.of(context).pop();
      }
    }
  }
}
