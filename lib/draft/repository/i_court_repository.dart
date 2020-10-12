import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../entity/person.dart';
import '../entity/schedule.dart';
import '../entity/court.dart';

abstract class ICourtRepository {
  ValueListenable<Box<PersonModel>> getPeopleListenable();

  ValueListenable<Box<CourtModel>> getCourtsListenable();

  ValueListenable<Box<ScheduleModel>> getSchedulesListenable();

  void saveSchedule(ScheduleModel scheduleModel);

  int getCourtState(int id);

  bool isDateTimeAvailable(int id, DateTime dateTime);
}
