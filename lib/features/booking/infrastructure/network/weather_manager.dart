import 'package:tennis_court_reservation/core/constants.dart';
import '../dto/weather_model.dart';
import '../../../../core/network_helper.dart';
import '../../domain/interfaces/i_weather_manager.dart';
import '../../domain/value_objects/weather.dart';

class WeatherManager extends IWeatherManager {
  Future<List<Weather>> getDailyWeather() async {
    NetworkHelper networkHelper = NetworkHelper(kOpenMapWeatherUrl);

    var weatherData = await networkHelper.getData();

    return WeatherModel.fromJson(weatherData).toDomain;
  }
}

extension WeatherDTOConvert on WeatherModel {
  List<Weather> get toDomain => this.daily.map((value) => Weather(value.dateTime, value.pop)).toList();
}
