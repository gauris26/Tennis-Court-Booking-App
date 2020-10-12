import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tennis_court_reservation/features/booking/domain/entities/schedule.dart';
import '../domain/interfaces/i_court_repository.dart';
import 'package:tennis_court_reservation/features/booking/domain/entities/person.dart';
import 'package:tennis_court_reservation/features/booking/domain/entities/court.dart';
import 'package:tennis_court_reservation/core/injectable.dart';
import '../../booking/state/court_booking_cubit.dart';
import 'package:flutter/material.dart';
import '../view/booking_view.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({
    Key key,
  }) : super(key: key);

  @override
  BookingController createState() => BookingController();
}

class BookingController extends State<BookingPage> with SingleTickerProviderStateMixin {
  final ICourtRepository _courtRepository = get<ICourtRepository>(); //TODO
  final GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  DateTime selectedDate;
  DateTimeRange selectedTimeRange;
  PersonModel selectedPerson;
  CourtModel selectedCourt;

  @override
  void initState() {
    //Initialization
    selectedDate = DateTime.now();
    selectedTimeRange = DateTimeRange(
      start: selectedDate,
      end: selectedDate.add(Duration(minutes: 30)),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => BookingView(this);

  ScheduleCubit get cubit => ScheduleCubit(get<ICourtRepository>());

  void onSelectedDate(DateTime dateTime) => setState(() => selectedDate = dateTime);

  void onTimeRange(DateTimeRange range) => selectedTimeRange = range;

  void onSelectedPerson(PersonModel person) => selectedPerson = person;

  void onSelectedCourt(CourtModel court) => selectedCourt = court;

  void onSaveSchedule(BuildContext context) async {
    var error = perfomValidations();
    if (error.hasError) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    } else {
      Future.delayed(Duration(milliseconds: 300), () => Navigator.of(this.context).pop<String>("Court Booked!"));
      _courtRepository.saveSchedule(
        ScheduleModel(
          id: selectedDate.millisecondsSinceEpoch,
          start: selectedTimeRange.start,
          end: selectedTimeRange.end,
          person: selectedPerson,
          court: selectedCourt,
        ),
      );
    }
  }

  ValidationError perfomValidations() {
    if (selectedPerson == null) {
      return ValidationError(true, "Must choose a Responsible Person");
    } else if (selectedCourt == null) {
      return ValidationError(true, "Must choose a Tennis court");
    } else if (!_courtRepository.isDateTimeAvailable(selectedCourt.id, selectedTimeRange.start)) {
      return ValidationError(true, "The date is already booked!");
    }

    return ValidationError(false, "");
  }
}

class ValidationError {
  bool hasError = false;
  String errorMessage = "";

  ValidationError(this.hasError, this.errorMessage);
}
