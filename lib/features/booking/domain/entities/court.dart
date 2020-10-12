import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'court.g.dart';

@HiveType(typeId: 0)
class CourtModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int maxDailyBookings;

  CourtModel({this.id, this.name, this.maxDailyBookings});

  @override
  String toString() {
    return 'CourtModel{id: $id, name: $name, maxDailyBookings: $maxDailyBookings}';
  }

  @override
  List<Object> get props => [id, name, maxDailyBookings];
}
