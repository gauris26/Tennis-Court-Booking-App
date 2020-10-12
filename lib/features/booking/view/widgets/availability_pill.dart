import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailabilityPill extends StatefulWidget {
  final int slotTaken;
  final int slotQuantity;

  const AvailabilityPill({
    this.slotTaken = 0,
    this.slotQuantity = 3,
    Key key,
  }) : super(key: key);

  @override
  _AvailabilityPillState createState() => _AvailabilityPillState();
}

class _AvailabilityPillState extends State<AvailabilityPill> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.slotQuantity);
    return Transform.scale(
      scale: 0.7,
      alignment: Alignment.bottomCenter,
      child: Row(
        children: List.generate(widget.slotQuantity, (index) {
          var borderRadius = BorderRadius.only(
            topLeft: Radius.circular(index == 0 ? 10 : 0),
            bottomLeft: Radius.circular(index == 0 ? 10 : 0),
            topRight: Radius.circular(index == widget.slotQuantity - 1 ? 10 : 0),
            bottomRight: Radius.circular(index == widget.slotQuantity - 1 ? 10 : 0),
          );
          return Chip(
            backgroundColor: index < widget.slotTaken ? Colors.red[300] : Colors.grey.withOpacity(0.3),
            label: SizedBox.shrink(),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
          );
        }),
      ),
    );
  }
}
