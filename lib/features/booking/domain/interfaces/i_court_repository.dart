import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class ICourtRepository {
  ValueListenable<Box<K>> getSchedules<K extends HiveObject>();

  void saveSchedule<K extends HiveObject>(K scheduleModel);

  int getCourtState(int id);

  bool isDateTimeAvailable(int id, DateTime dateTime);
}
