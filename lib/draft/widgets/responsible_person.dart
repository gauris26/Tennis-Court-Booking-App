import 'package:tennis_court_reservation/core/injectable.dart';
import 'package:tennis_court_reservation/draft/repository/court_repository.dart';
import 'package:tennis_court_reservation/draft/repository/i_court_repository.dart';
import 'package:tennis_court_reservation/draft/widgets/dropdown_person_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tennis_court_reservation/core/constants.dart';
import 'package:hive/hive.dart';
import 'package:tennis_court_reservation/draft/entity/person.dart';
import 'custom_form_builder_dropdown.dart';

typedef SelectedDropDownItem = void Function(PersonModel);

class ResponsiblePerson extends StatefulWidget {
  final SelectedDropDownItem selectedDropDownItem;
  final GlobalKey<FormBuilderState> fbKey;

  const ResponsiblePerson({
    Key key,
    this.selectedDropDownItem,
    this.fbKey,
  }) : super(key: key);

  @override
  _ResponsiblePersonState createState() => _ResponsiblePersonState();
}

class _ResponsiblePersonState extends State<ResponsiblePerson> {
  CourtRepository courtRepository = get<ICourtRepository>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE4E5ED),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      height: 80,
      child: FormBuilder(
        child: ValueListenableBuilder<Box<PersonModel>>(
          valueListenable: courtRepository.getPeopleListenable(),
          builder: (context, Box<PersonModel> box, _) {
            return FormBuilder(
              key: widget.fbKey,
              child: FormBuilderDropdown<PersonModel>(
                attribute: "person",
                isDense: false,
                itemHeight: 80,
                hint: Text("Choose someone"),
                //initialValue: box.values.first,
                decoration: kInputDecoration.copyWith(fillColor: Colors.transparent),
                style: kTextStyleDaySelector.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6E7175),
                ),
                onChanged: (value) => widget.selectedDropDownItem(value),
                items: box.values
                    .map(
                      (person) => DropdownMenuItem<PersonModel>(
                        value: person,
                        child: DropdownPersonItem(person: person),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
