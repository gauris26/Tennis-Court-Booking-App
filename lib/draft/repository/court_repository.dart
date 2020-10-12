import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';
import 'i_court_repository.dart';
import '../entity/schedule.dart';
import 'package:hive/hive.dart';
import '../entity/person.dart';
import '../entity/court.dart';
import '../../core/extensions.dart';

class CourtRepository extends ICourtRepository {
  Box<PersonModel> responsiblePersonBox;
  Box<ScheduleModel> scheduleBox;
  Box<CourtModel> courtBox;

  CourtRepository() {
    responsiblePersonBox = Hive.box("People");
    scheduleBox = Hive.box("Schedules");
    courtBox = Hive.box("Courts");
  }

  @override
  ValueListenable<Box<PersonModel>> getPeopleListenable() => responsiblePersonBox.listenable();

  @override
  ValueListenable<Box<CourtModel>> getCourtsListenable() => courtBox.listenable();

  @override
  ValueListenable<Box<ScheduleModel>> getSchedulesListenable() => scheduleBox.listenable();

  @override
  void saveSchedule(ScheduleModel scheduleModel) => scheduleBox.add(scheduleModel);

  @override
  int getCourtState(int id) {
    int courtBooked = 0;

    return scheduleBox.values.where((e) => e.court.id == id).fold(courtBooked, (previousValue, element) {
      if (element.start.isToday) courtBooked++;

      return courtBooked;
    });
  }

  @override
  bool isDateTimeAvailable(int id, DateTime dateTime) {
    bool courtBooked = true;

    return scheduleBox.values.where((e) => e.court.id == id).fold(courtBooked, (previousValue, element) {
      print(
          "Date: $dateTime isBetween: ${dateTime.toUTCDateTime.isAfter(element.start.toUTCDateTime) && dateTime.toUTCDateTime.isBefore(element.end.toUTCDateTime)}");
      if (dateTime.toUTCDateTime.isAfter(element.start.toUTCDateTime) && dateTime.toUTCDateTime.isBefore(element.end.toUTCDateTime)) courtBooked = false;

      return courtBooked;
    });
  }
}
