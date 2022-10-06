import 'package:attendance/screens/initialsubject.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import './userDetails.dart';
part 'subjectDetails.g.dart';

@HiveType(typeId: 2)
class SubjectDetails {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String subjectName;
  @HiveField(2)
  final int totalClassesTaken;
  @HiveField(3)
  final int totalClassesAttended;
  SubjectDetails({
    this.id,
    required this.subjectName,
    required this.totalClassesTaken,
    required this.totalClassesAttended,
  });

  //Adding details to Hive DB

}

Future<void> creatingDB(
    List<SubjectDetails> subjectDetails, UserDetails _currentUser) async {
  //Storing Inforamation about the usesr

  //Opening user DB to store data's
  final userDB = await Hive.openBox<UserDetails>('UserDB');
  //optaining the id given by hive and assign it as id of our userDB content
  final _id = await userDB.add(_currentUser);

  _currentUser.id = _id;

  final subjectDB = await Hive.openBox<SubjectDetails>('SubjectDB');
  //Accepting a list of subjectDetails and adding them to subjectDB based on
  //subject Details model class
  subjectDetails.map((subjectDetail) async {
    final _subjectId = await subjectDB.add(subjectDetail);
    subjectDetail.id = _subjectId;
    print('testing id $_subjectId');
  }).toList();
  retreiveUserDetails();
  // print('passing data$subjectDetails');
}

List<String> weeks = [];
List<String> subjects = [];
ValueNotifier<Map<int?, List<int>>> classAttended = ValueNotifier({});
List<String> userInfo = [];
//Fetching Informations from DB
Future<void> retreiveUserDetails() async {
  //weeks.clear();
  subjects.clear();
  classAttended.value.clear();
  final getUserDetails = await Hive.openBox<UserDetails>("UserDB");
  //Collecting user Information to userInfo, it is passed to userInfo Screen
  userInfo.add(getUserDetails.values.first.name);
  userInfo.add(getUserDetails.values.first.totalSubject.toString());
  userInfo.add(getUserDetails.values.first.attendancePercentage.toString());

  weeks = getUserDetails.values.first.workingDays;
  final _subjectsDetails = await Hive.openBox<SubjectDetails>("SubjectDB");
  // print(getUserDetails.values.first.);
  _subjectsDetails.values.map((subj) {
    subjects.add(subj.subjectName);
    print('iddd${subj.id}');
    if (subj.id != null) {
      classAttended.value.addAll({
        subj.id: [subj.totalClassesAttended, subj.totalClassesTaken]
      });
    }
    print('calss Ateed${classAttended.value.values}');
  }).toList();
  //  week.addAll(getUserDetails.values[]);
  classAttended.notifyListeners();
  print('id is${_subjectsDetails.values.first.id}');
}

Future<void> present(SubjectDetails seleSub) async {
  final present = await Hive.openBox<SubjectDetails>('SubjectDB');
  final presentSubj =
      present.values.firstWhere((subject) => subject.id == seleSub.id);
  SubjectDetails _updatedSubj = SubjectDetails(
    id: presentSubj.id,
    subjectName: presentSubj.subjectName,
    totalClassesTaken: presentSubj.totalClassesTaken + 1,
    totalClassesAttended: presentSubj.totalClassesAttended + 1,
  );
  print(_updatedSubj.id);
  if (_updatedSubj.id != null) {
    present.putAt(_updatedSubj.id!, _updatedSubj);
  } else {
    print('updation FAiled :${_updatedSubj.id}');
  }
  retreiveUserDetails();
  classAttended.notifyListeners();
//  present.put(seleSub.id, seleSub.totalClassesAttended+1)
}

//Updating SubjectTable if Abscent
Future<void> abscent(SubjectDetails seleSub) async {
  final abscent = await Hive.openBox<SubjectDetails>('SubjectDB');
  final presentSubj =
      abscent.values.firstWhere((subject) => subject.id == seleSub.id);
  //Incrementing totalClasses and keeping same the classes present
  SubjectDetails _updatedSubj = SubjectDetails(
    id: presentSubj.id,
    subjectName: presentSubj.subjectName,
    totalClassesTaken: presentSubj.totalClassesTaken + 1,
    totalClassesAttended: presentSubj.totalClassesAttended,
  );
  print('ih${_updatedSubj.id}');
  if (_updatedSubj.id != null) {
    abscent.putAt(_updatedSubj.id!, _updatedSubj);
  } else {
    print('updation FAiled :${_updatedSubj.id}');
  }
  retreiveUserDetails();
  classAttended.notifyListeners();
}

Future<void> updateTotalClassess(
    int? key, int totalClass, int presentClasses) async {
  print('key$key');
  final _openSub = await Hive.openBox<SubjectDetails>('SubjectDB');
  final _selectSubj = _openSub.values.firstWhere((_subj) => _subj.id == key);
  SubjectDetails _updateSubj = SubjectDetails(
      id: _selectSubj.id,
      subjectName: _selectSubj.subjectName,
      totalClassesTaken: totalClass,
      totalClassesAttended: presentClasses);
  print('clss$_selectSubj');
  if (_updateSubj.id != null) {
    _openSub.putAt(_updateSubj.id!, _updateSubj);
  }
  final sub = _openSub.values.firstWhere((subj) => subj.id == _selectSubj.id);
  retreiveUserDetails();
  classAttended.notifyListeners();
}

/*Updaing User Details in UserDB*/
Future<void> updateUserDetails(
    String updatedUserName, int updatedPercentage) async {
  final _openUserDB = await Hive.openBox<UserDetails>("UserDB");
  final _existingUser = _openUserDB.values.first;
  UserDetails _updateUser = UserDetails(
      id: _existingUser.id,
      name: updatedUserName,
      totalSubject: _existingUser.totalSubject,
      numOfPeriods: _existingUser.numOfPeriods,
      attendancePercentage: updatedPercentage,
      workingDays: _existingUser.workingDays,
      timeTableAdded: _existingUser.timeTableAdded,
      subjects: _existingUser.subjects);
  _openUserDB.putAt(_updateUser.id!, _updateUser);
  retreiveUserDetails();
}

Future<void> addNewSubject(
    String newSubjecName, int newNoofClassPresent, int newTotalClass) async {
  final _openSubject = await Hive.openBox<SubjectDetails>('SubjectDB');
  SubjectDetails _newSubject = SubjectDetails(
      subjectName: newSubjecName,
      totalClassesTaken: newTotalClass,
      totalClassesAttended: newNoofClassPresent);
  final _newSubjID = await _openSubject.add(_newSubject);
  _newSubject.id = _newSubjID;
  retreiveUserDetails();
}
