import 'package:flutter/material.dart';
import 'package:tennis_court_reservation/draft/widgets/precipitation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tennis_court_reservation/core/constants.dart';

class CurrentDateSelector extends StatefulWidget {
  final DateTime currentDateTime;
  const CurrentDateSelector({Key key, this.currentDateTime}) : super(key: key);

  @override
  _CurrentDateSelectorState createState() => _CurrentDateSelectorState();
}

class _CurrentDateSelectorState extends State<CurrentDateSelector> {
  @override
  void initState() {
    initializeDateFormatting('en_US', null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var datetime = (widget.currentDateTime != null ? widget.currentDateTime : DateTime.now());
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 90,
        height: 200,
        decoration: BoxDecoration(
          color: kAccentColor,
          borderRadius: BorderRadius.all(Radius.circular(45)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              datetime.day.toString().padLeft(2, '0'),
              style: kTextStyleDaySelector.copyWith(color: Colors.white),
            ),
            Precipitation(dateTime: widget.currentDateTime),
            Text(
              DateFormat(DateFormat.ABBR_WEEKDAY, "en_US").format(datetime).substring(0, 2),
              style: kTextStyleDaySelector.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
