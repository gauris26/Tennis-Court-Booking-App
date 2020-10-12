import 'package:hive/hive.dart';
/*
import 'package:tennis_court_reservation/draft/entity/court.dart';
import 'package:tennis_court_reservation/draft/entity/person.dart';
import 'package:tennis_court_reservation/draft/entity/schedule.dart';
*/
import '../features/domain_api.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> setupHive() async {
  //Hive config
  //final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  // Get the chosen sub-directory for Hive files
  //var hiveDb = Directory(appDocumentDir.path);
  //hiveDb.delete(recursive: true);

  await Hive.initFlutter();

  Hive.registerAdapter(CourtModelAdapter());
  await Hive.openBox<CourtModel>('Courts');

  Hive.registerAdapter(PersonModelAdapter());
  await Hive.openBox<PersonModel>('People');

  Hive.registerAdapter(ScheduleModelAdapter());
  await Hive.openBox<ScheduleModel>('Schedules');
}

void seed() {
  var courts = Hive.box<CourtModel>('Courts');

  courts.put(1, CourtModel(id: 1, name: "Court A", maxDailyBookings: 3));
  courts.put(2, CourtModel(id: 2, name: "Court B", maxDailyBookings: 3));
  courts.put(3, CourtModel(id: 3, name: "Court C", maxDailyBookings: 3));

  print(courts.values);

  var people = Hive.box<PersonModel>('People');

  people.put(1, PersonModel(id: 1, name: "Orlando Ortega Linares", imageUrl: "https://tinyfac.es/data/avatars/BA0CB1F2-8C79-4376-B13B-DD5FB8772537-200w.jpeg"));
  people.put(2, PersonModel(id: 2, name: "Samuel Medina Abreu", imageUrl: "https://tinyfac.es/data/avatars/26CFEFB3-21C8-49FC-8C19-8E6A62B6D2E0-200w.jpeg"));
  people.put(3, PersonModel(id: 3, name: "Sarah Hemingway", imageUrl: "https://tinyfac.es/data/avatars/A7299C8E-CEFC-47D9-939A-3C8CA0EA4D13-200w.jpeg"));
  people.put(4, PersonModel(id: 4, name: "Mary Amparo", imageUrl: "https://tinyfac.es/data/avatars/03F55412-DE8A-4F83-AAA6-D67EE5CE48DA-200w.jpeg"));

  //var schedules = Hive.box<ScheduleModel>('Schedules');
  //schedules.deleteFromDisk();
  //print(schedules.values);
}
