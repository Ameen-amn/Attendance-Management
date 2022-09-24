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
  final List<String> week = [];
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
  });
}

List<String> weeks = [];
Future<void> retreiveUserDetails() async {
  final getUserDetails = await Hive.openBox<UserDetails>("UserDB");
  // print(getUserDetails.values.first.);
  weeks = getUserDetails.values.first.workingDays;
  print(weeks);
  //  week.addAll(getUserDetails.values[]);
}
