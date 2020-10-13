import 'package:dartz/dartz.dart';
import 'package:tennis_court_reservation/features/booking/domain/failures/failure.dart';

import '../value_objects/weather.dart';

abstract class IWeatherManager {
  Future<Either<Failure, List<Weather>>> getDailyWeather();
}
