import 'package:get_it/get_it.dart';
import '../features/domain_api.dart';
import 'package:hive/hive.dart';

final get = GetIt.instance;

void setupLocator() {
  get.registerLazySingleton<ICourtRepository>(() => CourtRepository());
  get.registerLazySingleton<IWeatherManager>(() => WeatherManager());
  get.registerSingleton<Box<ScheduleModel>>(Hive.box<ScheduleModel>('Schedules'));
  get.registerSingleton<Box<PersonModel>>(Hive.box<PersonModel>('People'));
  get.registerSingleton<Box<CourtModel>>(Hive.box<CourtModel>('Courts'));
}
