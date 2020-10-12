import 'package:flutter/material.dart';
import 'availability_pill.dart';
import 'package:tennis_court_reservation/core/constants.dart';
import 'package:tennis_court_reservation/features/booking/domain/entities/court.dart';

typedef PressedCallback = void Function(CourtModel);

class Court extends StatelessWidget {
  final CourtModel courtModel;
  final bool isSelected;
  final int courtBooked;
  final PressedCallback onPressed;
  const Court({
    Key key,
    this.onPressed,
    @required this.courtModel,
    this.isSelected = false,
    this.courtBooked = 0,
  }) : super(key: key);

  bool get isEnabled => courtModel.maxDailyBookings > courtBooked;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: Card(
        color: isSelected && isEnabled ? kAccentColor : kInactiveColor,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: isEnabled ? () => onPressed(courtModel) : null,
          child: Container(
            width: MediaQuery.of(context).size.width / 3.9,
            height: 160,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/tennis_court.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.07), BlendMode.dstATop),
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.sports_tennis,
                      size: 40,
                      color: Colors.white,
                    ),
                    SizedBox(height: 5),
                    Text(
                      this.courtModel.name,
                      style: kTextStyleDaySelector.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                AvailabilityPill(
                  slotTaken: courtBooked,
                  slotQuantity: courtModel.maxDailyBookings,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
