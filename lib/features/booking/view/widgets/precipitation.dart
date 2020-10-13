import 'package:dartz/dartz.dart' as z;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tennis_court_reservation/core/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tennis_court_reservation/features/booking/domain/failures/failure.dart';
import '../../domain/interfaces/i_weather_repository.dart';
import '../../domain/value_objects/weather.dart';
import '../../../../core/injectable.dart';
import '../../../../core/extensions.dart';

class Precipitation extends StatefulWidget {
  final DateTime dateTime;
  final Color color;
  const Precipitation({
    this.dateTime,
    this.color = Colors.white,
    Key key,
  }) : super(key: key);

  @override
  _PrecipitationState createState() => _PrecipitationState();
}

class _PrecipitationState extends State<Precipitation> {
  IWeatherManager weatherManager = get<IWeatherManager>();
  Future<z.Either<Failure, List<Weather>>> weather;

  @override
  void initState() {
    weather = weatherManager.getDailyWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Align(
          alignment: Alignment.center,
          child: Icon(
            FontAwesomeIcons.cloudRain,
            color: widget.color,
            size: 16,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        FutureBuilder<z.Either<Failure, List<Weather>>>(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinKitPulse(
                size: 18,
                color: widget.color,
              );
            }

            return snapshot.data.fold(
              (l) => Icon(
                Icons.error_outline_outlined,
                color: Colors.redAccent,
                size: 20,
              ),
              (r) => Baseline(
                baseline: 0.2,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  "${r.todayWeather.percent}%",
                  style: kTextStyleDaySelector.copyWith(
                    color: widget.color,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

/*  bool isToday(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);

    final temp = widget?.dateTime ?? DateTime.now();
    var end = DateTime(temp.year, temp.month, temp.day);

    return start.difference(end).inDays == 0;
  }*/
}
