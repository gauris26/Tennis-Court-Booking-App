class Weather {
  DateTime datetime;
  double precipitation;

  Weather(this.datetime, this.precipitation);

  Weather.empty()
      : datetime = DateTime.now(),
        precipitation = 0;
}
