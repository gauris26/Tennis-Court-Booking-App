import 'package:tennis_court_reservation/draft/widgets/swipeable_confirm_button.dart';
import 'package:tennis_court_reservation/draft/widgets/time_and_duration_picker.dart';
import 'package:tennis_court_reservation/draft/widgets/current_date_selector.dart';
import 'package:tennis_court_reservation/draft/widgets/court_availability.dart';
import 'package:tennis_court_reservation/draft/widgets/responsible_person.dart';
import 'package:tennis_court_reservation/draft/widgets/date_selector.dart';
import 'package:tennis_court_reservation/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/booking_controller.dart';
import 'package:widget_view/widget_view.dart';
import 'package:flutter/material.dart';

class BookingView extends StatefulWidgetView<BookingPage, BookingController> {
  const BookingView(BookingController controller) : super(controller);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => controller.cubit,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: DateSelector(
                                  onChanged: controller.onSelectedDate,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  color: kBackGroundColor,
                                  padding: const EdgeInsets.only(top: 130),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: kSymmetricHorizontal,
                                        child: TimeAndDurationPicker(
                                          currentDateTime: controller.selectedDate,
                                          onDurationChange: controller.onTimeRange,
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      Padding(
                                        padding: kSymmetricHorizontal.copyWith(left: 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(flex: 2, child: Container()),
                                            Expanded(
                                              flex: 10,
                                              child: ResponsiblePerson(
                                                fbKey: controller.fbKey,
                                                selectedDropDownItem: controller.onSelectedPerson,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      Padding(
                                        padding: kSymmetricHorizontal,
                                        child: CourtAvailability(
                                          selectedCourt: controller.onSelectedCourt,
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      Padding(
                                        padding: kSymmetricHorizontal,
                                        child: SwipeableConfirmButton(
                                          onSwipeCompleted: controller.onSaveSchedule,
                                          dismissible: !controller.perfomValidations().hasError,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0, -0.8),
                        child: IgnorePointer(
                          ignoring: true,
                          child: CurrentDateSelector(
                            currentDateTime: controller.selectedDate,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
