import 'package:flutter/material.dart';

class Daily {
  int dt;
  double pop;
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(dt * 1000).toUtc(); //Unix Timestamp UTC

  Daily({@required this.dt, @required this.pop});

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    pop = json['pop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['pop'] = this.pop;
    return data;
  }

  @override
  String toString() {
    return 'Daily{dt: $dt, pop: $pop, dateTime: $dateTime}';
  }
}
