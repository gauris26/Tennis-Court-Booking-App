import 'package:intl/intl.dart';

import '../draft/entity/schedule.dart';
import 'package:hive/hive.dart';

extension DateTimeToCleanDate on DateTime {
  DateTime get toPlainDate => DateTime(this.year, this.month, this.day);
  DateTime get toUTCDate => DateTime.utc(this.year, this.month, this.day);
  DateTime get toUTCDateTime => DateTime.utc(this.year, this.month, this.day, this.hour, this.minute);

  String get toHumanReadable {
    int dayDiff = this.toUTCDate.difference(DateTime.now().toUTCDate).inDays;

    bool isToday = dayDiff == 0;
    bool isTomorrow = dayDiff == 1;
    bool isDayAfterTomorrow = dayDiff == 2;

    String humanReadableText = "";

    if (isToday) {
      humanReadableText = "Today";
    } else if (isTomorrow) {
      humanReadableText = "Tomorrow";
    } else if (isDayAfterTomorrow) {
      humanReadableText = "Day after tomorrow";
    } else {
      humanReadableText = DateFormat.yMMMd('en_US').format(this);
    }

    return humanReadableText;
  }

  bool get isPastDate => this.toUTCDate.compareTo(DateTime.now().toUTCDate.subtract(Duration(days: 1))) == 0;
  bool get isToday => this.toUTCDate.compareTo(DateTime.now().toUTCDate.subtract(Duration(days: 1))) == 1;
}

extension ExCourtRepository on Box<ScheduleModel> {
  List<ScheduleModel> get skipPastBooking {
    List<ScheduleModel> list = [];

    this.values.forEach((element) {
      if (element.end.toUTCDateTime.isAfter(DateTime.now().toUTCDateTime)) {
        list.add(element);
      }
    });

    return list;
  }
}
