import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tennis_court_reservation/draft/widgets/precipitation.dart';
import 'package:tennis_court_reservation/draft/entity/schedule.dart';
import 'package:tennis_court_reservation/core/extensions.dart';
import 'package:tennis_court_reservation/core/constants.dart';
import '../../../draft/widgets/right_child_time_line.dart';
import '../../../draft/widgets/left_child_time_line.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:grouped_list/grouped_list.dart';
import '../../../draft/models/step.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'booking_controller.dart';
import '../view/home_view.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  HomeController createState() => HomeController();
}

class HomeController extends State<HomePage> {
  final today = DateTime.now();
  final snackBar = SnackBar(
    content: Text('Court booking deleted'),
  );

  @override
  Widget build(BuildContext context) => HomeView(this);

  Future<void> navToBookingPage() async {
    String message = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => BookingPage()),
    );

    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message ?? "")));
  }

  Future<void> showConfirmationDialog({VoidCallback onPressed}) async {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget continueButton = FlatButton(
      child: Text("Confirm"),
      onPressed: () {
        onPressed();
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete court Booking"),
      content: Text("Are you sure to delete this court booking?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    await showDialog(context: context, builder: (BuildContext context) => alert);
  }

  TimelineTile generateHeaderTimelineTile(int groupByValue, [bool isFirst = false]) {
    var dateKey = DateTime.fromMillisecondsSinceEpoch(groupByValue);

    var step = StepTimeline(
      type: TypeTimeline.checkpoint,
      color: kAccentColor,
      title: "\n" + dateKey.toHumanReadable,
      icon: Icons.calendar_today_outlined,
    );

    IndicatorStyle indicator = _indicatorStyleCheckpoint(step);

    var rightChild = RightChildTimeline(step: step);

    return TimelineTile(
      key: UniqueKey(),
      alignment: TimelineAlign.manual,
      isFirst: isFirst,
      isLast: false,
      lineXY: 0.30,
      indicatorStyle: indicator,
      startChild: Precipitation(
        key: ValueKey(groupByValue),
        color: kAccentColor,
        dateTime: DateTime.fromMillisecondsSinceEpoch(groupByValue),
      ),
      endChild: rightChild,
      hasIndicator: true,
      beforeLineStyle: LineStyle(
        color: kAccentColor,
        thickness: 5,
      ),
    );
  }

  Future<void> deleteSchedule(ScheduleModel schedule) async {
    await schedule.delete();
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget generateTimelineTile(ScheduleModel schedule, int index, bool shouldLeftIndicator) {
    Duration rangeDuration = schedule.end.difference(schedule.start);

    final StepTimeline step = StepTimeline(
      type: TypeTimeline.line,
      color: kAccentColor,
      onIndicatorTap: () => showConfirmationDialog(
        onPressed: () => deleteSchedule(schedule),
      ),
      icon: Icons.calendar_today_outlined,
      hour: kFormatTime.format(schedule.start),
      duration: rangeDuration.inMinutes ~/ 30,
      title: schedule.person?.name,
      court: schedule.court.name,
      durationReadable: prettyDuration(rangeDuration),
    );

    final IndicatorStyle indicator = _indicatorStyleDelete(step, index);

    final rightChild = RightChildTimeline(step: step);

    Widget leftChild;
    if (step.hasHour && !shouldLeftIndicator) {
      leftChild = LeftChildTimeline(step: step);
    }

    return TimelineTile(
      key: UniqueKey(),
      alignment: TimelineAlign.manual,
      lineXY: 0.30,
      indicatorStyle: indicator,
      startChild: leftChild != null
          ? AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: leftChild,
                ),
              ),
            )
          : null,
      endChild: AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 375),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: rightChild,
          ),
        ),
      ),
      hasIndicator: true,
      beforeLineStyle: LineStyle(
        color: step.color,
        thickness: 5,
      ),
    );
  }

  Widget buildTimeline(List<ScheduleModel> schedules, Widget child, bool isFirstGroup) {
    return AnimatedCrossFade(
      crossFadeState: schedules.isEmpty ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 800),
      firstChild: GroupedListView<ScheduleModel, int>(
        elements: schedules,
        shrinkWrap: true,
        groupBy: (group) => group.start.toPlainDate.millisecondsSinceEpoch,
        indexedItemBuilder: (context, schedule, index) {
          bool hasSameHourThanPrevious = index == 0 ? false : schedules[index - 1].start.toUTCDateTime.difference(schedule.start.toUTCDateTime).inMinutes == 0;

          return generateTimelineTile(schedule, index, hasSameHourThanPrevious);
        },
        itemComparator: (item1, item2) => item1.start.compareTo(item2.start),
        order: GroupedListOrder.ASC,
        groupSeparatorBuilder: (int groupByValue) {
          Widget groupTimelineTile = generateHeaderTimelineTile(groupByValue, isFirstGroup);
          isFirstGroup = false;
          return groupTimelineTile;
        },
      ),
      secondChild: child,
    );
  }

  IndicatorStyle _indicatorStyleCheckpoint(StepTimeline step) {
    return IndicatorStyle(
      width: 50,
      height: 50,
      indicator: Container(
        decoration: BoxDecoration(
          color: step.color,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Center(
          child: Icon(
            step.icon,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
    );
  }

  IndicatorStyle _indicatorStyleDelete(StepTimeline step, int index) {
    return IndicatorStyle(
      width: 25,
      height: 25,
      indicatorXY: 0.5,
      indicator: AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 375),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: GestureDetector(
              onTap: step?.onIndicatorTap,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
