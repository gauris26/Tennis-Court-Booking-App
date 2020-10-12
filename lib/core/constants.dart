import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../features/domain_api.dart';

const kAccentColor = const Color(0xFF323EA7);

const kBackGroundColor = const Color(0xFFF5F5F5);

const kInactiveColor = const Color(0xFF555875);

const kCourtLatitude = 18.484373;

const kCourtLongitude = -69.956587;

final kFormatDate = DateFormat("yyyy-MM-dd");

final kFormatTime = DateFormat("hh:mm a");

final kFormatDateHumanRead = DateFormat("hh:mm a");

const kSymmetricHorizontal = const EdgeInsets.symmetric(horizontal: 18);

const kOpenMapWeatherApiKey = "1d38bb57edef07e9bb61575b29d95c1b";

const kOpenMapWeatherUrl =
    "https://api.openweathermap.org/data/2.5/onecall?lat=$kCourtLatitude&lon=$kCourtLongitude&appid=$kOpenMapWeatherApiKey&units=metric&exclude=current,minutely,hourly,alerts";

const kTextStyleDaySelector = const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

const kInputBorderOutline = const OutlineInputBorder(borderSide: BorderSide(color: Color(0x329E9E9E)));

const kInputDecoration = const InputDecoration(
  fillColor: Colors.white,
  filled: true,
  border: kInputBorderOutline,
  focusedBorder: kInputBorderOutline,
  disabledBorder: kInputBorderOutline,
  enabledBorder: kInputBorderOutline,
);

final List<DurationValue> kDurationValues = [
  DurationValue(Duration(minutes: 30), "30 minutes"),
  DurationValue(Duration(hours: 1), "1 hours"),
  DurationValue(Duration(hours: 2), "2 hours"),
  DurationValue(Duration(hours: 3), "3 hours"),
];

const kCalendarImage = "assets/images/calendar.png";

const kTennisCourtImage = "assets/images/tennis_court.png";
