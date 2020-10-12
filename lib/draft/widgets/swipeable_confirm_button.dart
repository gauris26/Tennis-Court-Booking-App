import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';
import 'package:tennis_court_reservation/core/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

typedef SwipeCompleted = void Function(BuildContext);

class SwipeableConfirmButton extends StatefulWidget {
  final SwipeCompleted onSwipeCompleted;
  final bool dismissible;
  const SwipeableConfirmButton({
    Key key,
    this.onSwipeCompleted,
    this.dismissible,
  }) : super(key: key);

  @override
  _SwipeableConfirmButtonState createState() => _SwipeableConfirmButtonState();
}

class _SwipeableConfirmButtonState extends State<SwipeableConfirmButton> {
  bool isDismissed = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 800),
      crossFadeState: !isDismissed ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: SliderButton(
        action: () {
          setState(() {
            //isDismissed = !isDismissed;
            widget.onSwipeCompleted(context);
          });
        },

        dismissible: widget.dismissible,
        shimmer: false,

        ///Put label over here
        label: Text(
          "Confirm",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
        icon: Center(
          child: Icon(
            Icons.double_arrow_rounded,
            color: Colors.white,
            size: 40.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
        ),
        //dismissThresholds: 0.8,
        ///Change All the color and size from here.
        width: MediaQuery.of(context).size.width - (kSymmetricHorizontal.horizontal),
        radius: 10,
        boxShadow: BoxShadow(
          color: Colors.white,
          offset: Offset(2, 0),
          spreadRadius: 1,
          blurRadius: 8,
        ),
        buttonColor: kAccentColor,
        backgroundColor: kInactiveColor,
        highlightedColor: Colors.white,
        baseColor: Colors.white,
      ),
      secondChild: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SpinKitRing(
            color: kAccentColor,
            lineWidth: 8,
          ),
        ),
      ),
    );
  }
}
