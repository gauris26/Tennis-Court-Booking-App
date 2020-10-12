import 'package:tennis_court_reservation/core/constants.dart';
import 'package:tennis_court_reservation/draft/models/dto/weather_model.dart';

import 'networking.dart';

class WeatherManager {
  Future<WeatherModel> getCourtWeather() async {
    NetworkHelper networkHelper = NetworkHelper(kOpenMapWeatherUrl);

    var weatherData = await networkHelper.getData();

    return WeatherModel.fromJson(weatherData);
  }
}
