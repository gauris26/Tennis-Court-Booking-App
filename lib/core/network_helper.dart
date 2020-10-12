import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<dynamic> getData() async {
/*    String data = cachedResponse;
    await Future.delayed(Duration(milliseconds: 1000));
    return jsonDecode(data);*/

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

const cachedResponse = '''
{
    "lat": 18.48,
    "lon": -69.96,
    "timezone": "America/Santo_Domingo",
    "timezone_offset": -14400,
    "daily": [
        {
            "dt": 1602259200,
            "sunrise": 1602239521,
            "sunset": 1602282095,
            "temp": {
                "day": 29.63,
                "min": 23.82,
                "max": 30.86,
                "night": 26.22,
                "eve": 30.32,
                "morn": 23.82
            },
            "feels_like": {
                "day": 33.52,
                "night": 30.42,
                "eve": 36.63,
                "morn": 27.39
            },
            "pressure": 1017,
            "humidity": 67,
            "dew_point": 23.04,
            "wind_speed": 1.8,
            "wind_deg": 81,
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": 85,
            "pop": 0.21,
            "rain": 0.1,
            "uvi": 10.05
        },
        {
            "dt": 1602345600,
            "sunrise": 1602325936,
            "sunset": 1602368449,
            "temp": {
                "day": 30.1,
                "min": 24.12,
                "max": 31.96,
                "night": 25.31,
                "eve": 30.84,
                "morn": 24.12
            },
            "feels_like": {
                "day": 33.54,
                "night": 28.83,
                "eve": 34.86,
                "morn": 27.01
            },
            "pressure": 1016,
            "humidity": 70,
            "dew_point": 24.08,
            "wind_speed": 3.4,
            "wind_deg": 38,
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": 59,
            "pop": 0.32,
            "rain": 0.22,
            "uvi": 10.18
        },
        {
            "dt": 1602432000,
            "sunrise": 1602412351,
            "sunset": 1602454802,
            "temp": {
                "day": 30.12,
                "min": 24.5,
                "max": 30.58,
                "night": 25.29,
                "eve": 28.52,
                "morn": 24.5
            },
            "feels_like": {
                "day": 34.1,
                "night": 29.42,
                "eve": 32.59,
                "morn": 27.91
            },
            "pressure": 1015,
            "humidity": 67,
            "dew_point": 23.36,
            "wind_speed": 2.05,
            "wind_deg": 62,
            "weather": [
                {
                    "id": 501,
                    "main": "Rain",
                    "description": "moderate rain",
                    "icon": "10d"
                }
            ],
            "clouds": 14,
            "pop": 0.81,
            "rain": 8.33,
            "uvi": 10.18
        },
        {
            "dt": 1602518400,
            "sunrise": 1602498766,
            "sunset": 1602541157,
            "temp": {
                "day": 29.72,
                "min": 24.13,
                "max": 29.72,
                "night": 25.06,
                "eve": 27.57,
                "morn": 24.13
            },
            "feels_like": {
                "day": 33.09,
                "night": 29.1,
                "eve": 31.38,
                "morn": 27.56
            },
            "pressure": 1014,
            "humidity": 65,
            "dew_point": 22.64,
            "wind_speed": 2.22,
            "wind_deg": 66,
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": 31,
            "pop": 0.79,
            "rain": 2.52,
            "uvi": 9.76
        },
        {
            "dt": 1602604800,
            "sunrise": 1602585182,
            "sunset": 1602627512,
            "temp": {
                "day": 29.52,
                "min": 23.69,
                "max": 30.09,
                "night": 24.92,
                "eve": 27.93,
                "morn": 23.69
            },
            "feels_like": {
                "day": 32.5,
                "night": 28.83,
                "eve": 31.41,
                "morn": 27.15
            },
            "pressure": 1012,
            "humidity": 63,
            "dew_point": 21.93,
            "wind_speed": 2.25,
            "wind_deg": 46,
            "weather": [
                {
                    "id": 501,
                    "main": "Rain",
                    "description": "moderate rain",
                    "icon": "10d"
                }
            ],
            "clouds": 0,
            "pop": 0.6,
            "rain": 3.41,
            "uvi": 10.02
        },
        {
            "dt": 1602691200,
            "sunrise": 1602671598,
            "sunset": 1602713868,
            "temp": {
                "day": 29.3,
                "min": 23.21,
                "max": 29.89,
                "night": 24.56,
                "eve": 28.01,
                "morn": 23.21
            },
            "feels_like": {
                "day": 32.63,
                "night": 28.08,
                "eve": 30.92,
                "morn": 26.34
            },
            "pressure": 1012,
            "humidity": 63,
            "dew_point": 21.71,
            "wind_speed": 1.59,
            "wind_deg": 91,
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": 0,
            "pop": 0.21,
            "uvi": 10.16
        },
        {
            "dt": 1602777600,
            "sunrise": 1602758015,
            "sunset": 1602800224,
            "temp": {
                "day": 29.42,
                "min": 23.29,
                "max": 30.44,
                "night": 24.77,
                "eve": 28.85,
                "morn": 23.29
            },
            "feels_like": {
                "day": 33.02,
                "night": 28.22,
                "eve": 31.67,
                "morn": 26.36
            },
            "pressure": 1013,
            "humidity": 65,
            "dew_point": 22.17,
            "wind_speed": 1.68,
            "wind_deg": 92,
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": 1,
            "pop": 0.1,
            "uvi": 9.78
        },
        {
            "dt": 1602864000,
            "sunrise": 1602844432,
            "sunset": 1602886582,
            "temp": {
                "day": 29.68,
                "min": 23.62,
                "max": 30.9,
                "night": 25.15,
                "eve": 28.79,
                "morn": 23.62
            },
            "feels_like": {
                "day": 32.96,
                "night": 29.2,
                "eve": 32.16,
                "morn": 26.78
            },
            "pressure": 1014,
            "humidity": 62,
            "dew_point": 21.84,
            "wind_speed": 1.74,
            "wind_deg": 69,
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": 0,
            "pop": 0.58,
            "rain": 2.74,
            "uvi": 9.56
        }
    ]
}
''';
