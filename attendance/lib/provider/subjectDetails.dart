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
//Fetching Informations from DB
Future<void> retreiveUserDetails() async {
  //weeks.clear();
  subjects.clear();
  classAttended.value.clear();
  final getUserDetails = await Hive.openBox<UserDetails>("UserDB");
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

  print('id is${_subjectsDetails.values.first.id}');
}

/* Future<void> subjectDBCreation(List<SubjectDetails> _subjectDetails) async {
  final subjectDB = await Hive.openBox<SubjectDetails>('SubjectDB');
  _subjectDetails.map((subjectDetail) async {
    final _subjId = await subjectDB.add(subjectDetail);
    subjectDetail.id = _subjId;
  });
}

Future<void> retreiveSubjectDetails() async {
  final subjectss = await Hive.openBox<SubjectDetails>("SubjectDB");
  final id = subjectss.values.first.subjectName;
  print('sunn$id');
} */

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
