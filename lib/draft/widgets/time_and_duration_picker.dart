import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:tennis_court_reservation/core/constants.dart';

typedef void DurationChange(DateTimeRange dateTime);

class TimeAndDurationPicker extends StatefulWidget {
  final DurationChange onDurationChange;
  final DateTime currentDateTime;

  const TimeAndDurationPicker({
    this.onDurationChange,
    @required this.currentDateTime,
    Key key,
  }) : super(key: key);

  @override
  _TimeAndDurationPickerState createState() => _TimeAndDurationPickerState();
}

class _TimeAndDurationPickerState extends State<TimeAndDurationPicker> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Duration duration = Duration(minutes: 30);
  DateTime startTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: DateTimeField(
            format: kFormatTime,
            initialValue: DateTime.now(),
            decoration: kInputDecoration,
            style: kTextStyleDaySelector.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6E7175),
            ),
            textAlign: TextAlign.right,
            onChanged: (value) {
              startTime = value;
              widget.onDurationChange(calculateDateTimeRange());
            },
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
        ),
        SizedBox(width: 30),
        Flexible(
          child: FormBuilder(
            key: _fbKey,
            child: FormBuilderDropdown(
              attribute: "gender",
              initialValue: kDurationValues.first.value,
              decoration: kInputDecoration,
              validators: [FormBuilderValidators.required()],
              style: kTextStyleDaySelector.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6E7175),
              ),
              onChanged: (value) {
                duration = value;
                widget.onDurationChange(calculateDateTimeRange());
              },
              items: kDurationValues
                  .map((durationValue) => DropdownMenuItem<Duration>(
                        value: durationValue.value,
                        child: Text("${durationValue.text}"),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  DateTimeRange calculateDateTimeRange() {
    DateTime selectedDate = widget.currentDateTime ?? DateTime.now();

    DateTime tempDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, startTime.hour, startTime.minute);

    return DateTimeRange(start: tempDateTime, end: tempDateTime.add(duration));
  }
}
