import 'package:tennis_court_reservation/core/extensions.dart' show ExCourtRepository, DateTimeToCleanDate;
import 'package:tennis_court_reservation/draft/entity/schedule.dart';
import 'package:tennis_court_reservation/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_view/widget_view.dart';
import '../controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:ui';
import '../state/court_booking_cubit.dart';

class HomeView extends StatefulWidgetView<HomePage, HomeController> {
  const HomeView(HomeController controller) : super(controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kAccentColor,
        child: Icon(Icons.add),
        onPressed: controller.navToBookingPage,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tennis Court\nBooking App",
                          style: kTextStyleDaySelector.copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: kAccentColor,
                          ),
                        ),
                        Text(
                          "Practice tennis smart!",
                          style: kTextStyleDaySelector.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: kInactiveColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: kBackGroundColor,
                  padding: kSymmetricHorizontal.copyWith(right: 0),
                  child: ValueListenableBuilder<Box<ScheduleModel>>(
                    valueListenable: context.bloc<ScheduleCubit>().getSchedules(),
                    builder: (context, Box<ScheduleModel> box, child) {
                      bool isFirstGroup = true;

                      return controller.buildTimeline(box.skipPastBooking, child, isFirstGroup);
                    },
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image(
                            color: kAccentColor.withOpacity(0.5),
                            image: AssetImage(kCalendarImage),
                          ),
                        ),
                        Positioned(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 1.0,
                              sigmaY: 1.0,
                            ),
                            child: Image(
                              color: kInactiveColor.withOpacity(0.091),
                              image: AssetImage(kTennisCourtImage),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
