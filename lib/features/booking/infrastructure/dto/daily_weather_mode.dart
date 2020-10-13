import 'package:flutter/material.dart';
import '../../../../core/extensions.dart';

class Daily {
  int dt;
  double pop;
  DateTime get dateTime => dt.unixIntegerToDate; //Unix Timestamp UTC

  Daily({@required this.dt, @required this.pop});

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    pop = json['pop'].toDouble();
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
