import 'person.dart';
import 'court.dart';
import 'package:hive/hive.dart';

part 'schedule.g.dart';

@HiveType(typeId: 2)
class ScheduleModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  DateTime start;
  @HiveField(2)
  DateTime end;
  @HiveField(3)
  PersonModel person;
  @HiveField(4)
  CourtModel court;

  ScheduleModel({this.id, this.start, this.end, this.person, this.court});

  @override
  String toString() {
    return 'ScheduleModel{id: $id, start: $start, end: $end, person: $person, court: $court}';
  }
}
