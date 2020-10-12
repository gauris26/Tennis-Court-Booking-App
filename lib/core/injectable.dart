import 'package:get_it/get_it.dart';
import 'package:tennis_court_reservation/draft/repository/court_repository.dart';
import 'package:tennis_court_reservation/draft/repository/i_court_repository.dart';

final get = GetIt.instance;

void setupLocator() {
  get.registerLazySingleton<ICourtRepository>(() => CourtRepository());
}
