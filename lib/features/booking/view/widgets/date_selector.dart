import 'package:flutter/material.dart';
import 'package:tennis_court_reservation/core/constants.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

typedef void DateTimeScrollChange(DateTime dateTime);

class DateSelector extends StatefulWidget {
  final DateTimeScrollChange onChanged;

  const DateSelector({Key key, this.onChanged}) : super(key: key);

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  final controller = PageController(
    initialPage: 0,
    viewportFraction: 0.3,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: PageView(
        controller: controller,
        pageSnapping: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: List.generate(
          7,
          (index) {
            return Container(
              width: MediaQuery.of(context).size.width / 3,
              child: Align(
                alignment: Alignment(0, 0.365),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      buildMonthTitle(index),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, letterSpacing: 2, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      buildDayTitle(index),
                      style: kTextStyleDaySelector.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        onPageChanged: (index) => widget?.onChanged(buildIndexToDateTime(index)),
      ),
    );
  }

  String buildDayTitle(int index) => DateTime.now().add(Duration(days: index)).day.toString().padLeft(2, '0');

  String buildMonthTitle(int index) => DateFormat(DateFormat.ABBR_MONTH, "en_US").format(DateTime.now().add(Duration(days: index))).substring(0, 3);

  DateTime buildIndexToDateTime(int index) => DateTime.now().add(Duration(days: index));
}
