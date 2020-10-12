import 'package:flutter/material.dart';
import 'package:tennis_court_reservation/features/booking/domain/entities/person.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DropdownPersonItem extends StatelessWidget {
  final PersonModel person;
  const DropdownPersonItem({
    this.person,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        CircleAvatar(
          //radius: 30,
          backgroundColor: Colors.transparent,
          radius: 25.0,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: person.imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(child: Text("${person.name}")),
      ],
    );
  }
}
