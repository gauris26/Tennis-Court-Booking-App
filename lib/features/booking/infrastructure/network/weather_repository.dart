import 'package:dartz/dartz.dart';
import 'package:tennis_court_reservation/core/constants.dart';
import 'package:tennis_court_reservation/features/booking/domain/failures/failure.dart';
import '../dto/weather_model.dart';
import '../../../../core/network_helper.dart';
import '../../domain/interfaces/i_weather_repository.dart';
import '../../domain/value_objects/weather.dart';
import '../../../../core/extensions.dart';
import 'dart:convert';
import 'dart:io';

class WeatherManager extends IWeatherManager {
  List<Weather> response;

  Future<Either<Failure, List<Weather>>> getDailyWeather() async {
    NetworkHelper networkHelper = NetworkHelper(kOpenMapWeatherUrl);

    try {
      String data = await networkHelper.getResponseBody();
      var weatherData = WeatherModel.fromJson(jsonDecode(data)).toDomain;
      return Right(response = weatherData);
    } on SocketException {
      return Left(Failure('No Internet connection'));
    } on HttpException {
      return Left(Failure("Couldn't find the information"));
    } on FormatException {
      return Left(Failure("Bad response format"));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
