import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tennis_court_reservation/core/constants.dart';
import '../../domain/value_objects/step.dart';
import '../../../../core/extensions.dart';

class RightChildTimeline extends StatelessWidget {
  const RightChildTimeline({Key key, this.step}) : super(key: key);

  final StepTimeline step;

  @override
  Widget build(BuildContext context) {
    final double minHeight = step.isCheckpoint ? 92 : step.duration.toDouble() * 8;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: step.isCheckpoint ? 15 : 30, top: 8, bottom: 2, right: 8),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "${step.title}",
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      decoration: !step.isCheckpoint && step.dateTime.isOverdueDate ? TextDecoration.lineThrough : TextDecoration.none,
                      fontWeight: step.isCheckpoint ? FontWeight.bold : FontWeight.normal,
                      color: step.color,
                    ),
                  ),
                ),
              ),
              if (!step.isCheckpoint)
                Padding(
                  padding: EdgeInsets.only(left: 30, top: 2, bottom: 8, right: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: kAccentColor,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.book,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 1),
                            Text(
                              step.court,
                              textScaleFactor: 0.9,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: kAccentColor,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.hourglass_bottom_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 1),
                            Text(
                              step.durationReadable,
                              textScaleFactor: 0.9,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
