import '../value_objects/weather.dart';

abstract class IWeatherManager {
  Future<List<Weather>> getDailyWeather();
}
