import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../entities/person.dart';
import '../entities/schedule.dart';
import '../entities/court.dart';

abstract class ICourtRepository {
  /*ValueListenable<Box<PersonModel>> getPeopleListenable();

  ValueListenable<Box<CourtModel>> getCourtsListenable();

  ValueListenable<Box<ScheduleModel>> getSchedulesListenable();*/

  ValueListenable<Box<K>> getSchedules<K extends HiveObject>();

  void saveSchedule<K extends HiveObject>(K scheduleModel);

  int getCourtState(int id);

  bool isDateTimeAvailable(int id, DateTime dateTime);
}
