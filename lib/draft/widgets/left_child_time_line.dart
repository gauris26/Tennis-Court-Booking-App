import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tennis_court_reservation/core/constants.dart';
import '../models/step.dart';

class LeftChildTimeline extends StatelessWidget {
  const LeftChildTimeline({Key key, this.step}) : super(key: key);

  final StepTimeline step;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: step.isCheckpoint ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: step.isCheckpoint ? 10 : 29, top: step.isCheckpoint ? 0 : 8),
          child: Text(
            step.hour,
            textAlign: TextAlign.center,
            style: GoogleFonts.patrickHand(
              fontSize: 16,
              color: kInactiveColor.withOpacity(0.6),
            ),
          ),
        )
      ],
    );
  }
}
