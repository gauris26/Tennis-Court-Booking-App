import 'package:flutter/material.dart';
import 'package:tennis_court_reservation/draft/widgets/court.dart';
import 'package:tennis_court_reservation/draft/entity/court.dart';
import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_court_reservation/draft/repository/court_repository.dart';
import 'package:tennis_court_reservation/draft/repository/i_court_repository.dart';
import 'package:tennis_court_reservation/core/injectable.dart';
import '../../features/booking/state/court_booking_cubit.dart';

typedef SelectedCourtItem = void Function(CourtModel);

class CourtAvailability extends StatefulWidget {
  final SelectedCourtItem selectedCourt;
  const CourtAvailability({Key key, this.selectedCourt}) : super(key: key);

  @override
  _CourtAvailabilityState createState() => _CourtAvailabilityState();
}

class _CourtAvailabilityState extends State<CourtAvailability> {
  CourtModel selectedCourt;
  CourtRepository courtRepository = get<ICourtRepository>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<CourtModel>>(
        valueListenable: context.cubit.getCourts(),
        builder: (context, Box<CourtModel> box, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: box.values.map(
              (court) {
                int courtBooked = context.cubit.getCourtState(court.id);
                print("Court ID: ${court.id}");
                return Court(
                  key: ValueKey(court.id),
                  courtModel: court,
                  onPressed: (value) => setState(() {
                    widget.selectedCourt(value);
                    selectedCourt = value;
                  }),
                  isSelected: selectedCourt == court,
                  courtBooked: courtBooked,
                );
              },
            ).toList(),
          );
        });
  }
}

extension CourtRules on BuildContext {
  ScheduleCubit get cubit => this.bloc<ScheduleCubit>();
}
