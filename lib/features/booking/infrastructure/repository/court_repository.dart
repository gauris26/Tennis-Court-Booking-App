import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';
import '../../domain/interfaces/i_court_repository.dart';
import '../../domain/entities/schedule.dart';
import 'package:hive/hive.dart';
import '../../../../core/extensions.dart';
import '../../../../core/injectable.dart';

class CourtRepository extends ICourtRepository {
  @override
  ValueListenable<Box<K>> getSchedules<K extends HiveObject>() => get<Box<K>>().listenable();

  @override
  void saveSchedule<K extends HiveObject>(K model) => get<Box<K>>().add(model);

  @override
  int getCourtState(int id) {
    int courtBooked = 0;
    var scheduleBox = get<Box<ScheduleModel>>();

    return scheduleBox.values.where((e) => e.court.id == id).fold(courtBooked, (previousValue, element) {
      print(element.start.isToday);
      if (element.start.isToday) courtBooked++;

      return courtBooked;
    });
  }

  @override
  bool isDateTimeAvailable(int id, DateTime dateTime) {
    bool courtBooked = true;

    var scheduleBox = get<Box<ScheduleModel>>();

    //Subtract one minute to match in a inclusive way -Start Date
    //Add one minute to match in a inclusive way - End Date
    return scheduleBox.values.where((e) => e.court.id == id).fold(courtBooked, (previousValue, element) {
      bool isAfter = dateTime.toUTCDateTime.isAfter(element.start.toUTCDateTime.subtract(Duration(minutes: 1)));
      bool isBefore = dateTime.toUTCDateTime.isBefore(element.end.toUTCDateTime.add(Duration(minutes: 1)));
      if (isAfter && isBefore) courtBooked = false;

      return courtBooked;
    });
  }
}
