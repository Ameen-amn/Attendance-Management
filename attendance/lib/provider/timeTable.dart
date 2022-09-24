import 'package:hive/hive.dart';
part 'timeTable.g.dart';

@HiveType(typeId: 3)
class TimeTable {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String day;
  @HiveField(2)
  final List<String> subject;
  TimeTable({
    required this.day,
    required this.subject,
    this.id,
  });
  //Creating time table database
}
  Future<void> timeTableDB(List<String> workingDays,List<List<String>> timetable) async {
    final _timeTable = await Hive.openBox<TimeTable>('TimeTable');
    List.generate(timetable.length, (index) async {
      final today =
          TimeTable(day: workingDays[index], subject: timetable[index]);

      final _timeTableID = await _timeTable.add(today);
      today.id = _timeTableID;
    });
  }
