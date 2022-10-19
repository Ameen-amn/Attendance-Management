import 'package:attendance/screens/initialsubject.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import './userDetails.dart';
part 'subjectDetails.g.dart';

@HiveType(typeId: 2)
class SubjectDetails  {
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

Future<void> creatingDB  (
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

    subjectDB.put(_subjectId, subjectDetail);
    print('testing id $_subjectId');
  }).toList();
  retreiveUserDetails();
  // print('passing data$subjectDetails');
}

List<String> weeks = [];
ValueNotifier<List<String>> subjects = ValueNotifier([]);
ValueNotifier<Map<int?, List<int>>> classAttended = ValueNotifier({});
List<String> userInfo = [];
String status = '';
int percentage = 0;
int globalSubIndex = 0;
late String? currentSubj = subjects.value[globalSubIndex];
//Fetching Informations from DB
Future<void> retreiveUserDetails() async {
  //weeks.clear();
  userInfo.clear();
  subjects.value.clear();
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
    subjects.value.add(subj.subjectName);

    print('iddd${subj.id}');
    if (subj.id != null) {
      classAttended.value.addAll({
        subj.id: [subj.totalClassesAttended, subj.totalClassesTaken]
      });
    }
    print('calss Ateed${classAttended.value.values}');
  }).toList();
  //  week.addAll(getUserDetails.values[]);
  subjects.notifyListeners();
  classAttended.notifyListeners();
  final lastlist = classAttended.value.values.toList();

  if (lastlist[globalSubIndex][1] != 0) {
    percentage =
        ((lastlist[globalSubIndex][0] / lastlist[globalSubIndex][1]) * 100)
            .floor();
  }
  status = reqClasses(percentage, int.parse(userInfo[2]), globalSubIndex);
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
    present.put(_updatedSubj.id!, _updatedSubj);
  } else {
    print('updation FAiled :${_updatedSubj.id}');
  }
  await retreiveUserDetails();
  classAttended.notifyListeners();
  final lastlist = classAttended.value.values.toList();

  if (lastlist[globalSubIndex][1] != 0) {
    percentage =
        ((lastlist[globalSubIndex][0] / lastlist[globalSubIndex][1]) * 100)
            .floor();
  }
  status = reqClasses(percentage, int.parse(userInfo[2]), globalSubIndex);
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
    abscent.put(_updatedSubj.id!, _updatedSubj);
  } else {
    print('updation FAiled :${_updatedSubj.id}');
  }
  await retreiveUserDetails();
  classAttended.notifyListeners();
  final lastlist = classAttended.value.values.toList();

  if (lastlist[globalSubIndex][1] != 0) {
    percentage =
        ((lastlist[globalSubIndex][0] / lastlist[globalSubIndex][1]) * 100)
            .floor();
  }
  status = reqClasses(percentage, int.parse(userInfo[2]), globalSubIndex);
}

Future<void> updateTotalClassess(
    int? key, int totalClass, int presentClasses, String newSubjName) async {
  print('key$key');
  final _openSub = await Hive.openBox<SubjectDetails>('SubjectDB');
  final _selectSubj = _openSub.values.firstWhere((_subj) => _subj.id == key);
  SubjectDetails _updateSubj = SubjectDetails(
      id: _selectSubj.id,
      subjectName: newSubjName,
      totalClassesTaken: totalClass,
      totalClassesAttended: presentClasses);

  if (_updateSubj.id != null) {
    print('not here');
    _openSub.put(_updateSubj.id, _updateSubj);

    // _openSub.putAt(_updateSubj.id!, _updateSubj);

    print(' here');
  }

  await retreiveUserDetails();
  classAttended.notifyListeners();
  subjects.notifyListeners();
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
  _openUserDB.put(_updateUser.id!, _updateUser);
  retreiveUserDetails();
}

//Adding New Subject
Future<void> addNewSubject(
    String newSubjecName, int newNoofClassPresent, int newTotalClass) async {
  final _openSubject = await Hive.openBox<SubjectDetails>('SubjectDB');
  SubjectDetails _newSubject = SubjectDetails(
      subjectName: newSubjecName,
      totalClassesTaken: newTotalClass,
      totalClassesAttended: newNoofClassPresent);
  final _newSubjID = await _openSubject.add(_newSubject);
  _newSubject.id = _newSubjID;
  _openSubject.put(_newSubjID, _newSubject);

  await retreiveUserDetails();
  classAttended.notifyListeners();
  subjects.notifyListeners();
}

//Deleting Existing Subjects
Future<void> deleteSubject(int deleteSubjId) async {
  final _openSubject = await Hive.openBox<SubjectDetails>("SubjectDB");
  final _deleteSubjName =
      _openSubject.values.firstWhere((subj) => subj.id == deleteSubjId);

  await _openSubject.delete(deleteSubjId);
  classAttended.value.remove(deleteSubjId);
  subjects.value.remove(_deleteSubjName);
  print('class arrent${classAttended.value}');
  await retreiveUserDetails();
  subjects.notifyListeners();
  classAttended.notifyListeners();
}

//finding Subject
Future<SubjectDetails> findingSubject(int subjid) async {
  final _openSubj = await Hive.openBox<SubjectDetails>("SubjectDB");
  final reqSubj = _openSubj.values.firstWhere((_subj) => _subj.id == subjid);
  return reqSubj;
}

Future<bool> nameCheck(String subjName) async {
  bool exists = false;
  final _openBox = await Hive.openBox<SubjectDetails>("SubjectDB");
  _openBox.values.forEach((element) {
    if (element.subjectName == subjName) {
      exists = true;
    }
  });
  return exists;
}

String reqClasses(int percentage, int reqPercentage, int subjId) {
  final reqSubj = classAttended.value.entries
      .firstWhere((element) => element.key == subjId);
  int reqclass = 0;
  int totalClass = reqSubj.value[1];
  int attendedClass = reqSubj.value[0];
  print('req %$reqPercentage');
  print('percentage $percentage');
  print('toal cals$totalClass');
  print('attend class $attendedClass');
  if (reqPercentage == percentage) {
    return 'Reached your % attend 1 more to maintain';
  } else if (reqPercentage > percentage) {
    if (percentage == 0) {
      return 'Attend at least 1 class';
    }
    reqclass = ((totalClass * (reqPercentage / 100) - attendedClass) ~/
        (1 - (reqPercentage / 100)));
    print(' testing Statues$subjId $reqclass');
    return 'Attend $reqclass'; //classes to get your required Percentage
  } else if (reqPercentage < percentage) {
    reqclass = ((attendedClass - (totalClass * (reqPercentage / 100))) ~/
        (reqPercentage / 100));
    print('req clss $reqclass');
    reqclass = reqclass.floor();
    if (reqclass >= 1) {
      return 'You can skip $reqclass class';
    } else {
      return 'Skipping class will keep you off track';
    }
  } else {
    return 'Attend 1 more class '; //to maintain your required percentage';
  }
}
