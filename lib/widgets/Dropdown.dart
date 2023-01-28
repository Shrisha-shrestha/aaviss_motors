import 'package:flutter/material.dart';

class CustomDropdownwidget extends StatelessWidget {
  final List<String> list;
  final String droplabel;
  final String? dropdownvalue;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  const CustomDropdownwidget({
    super.key,
    required this.list,
    this.validator,
    required this.droplabel,
    this.dropdownvalue,
    this.onSaved,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String?>(
        validator: validator,
        disabledHint: Center(
          child: Text(
            dropdownvalue.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        menuMaxHeight: 160.0,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: droplabel,
          labelStyle: Theme.of(context).textTheme.caption,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
          ),
        ),
        value: dropdownvalue,
        items: list.map((e) {
          return DropdownMenuItem(
              value: e,
              child: Center(
                child: Text(
                  e,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 15.0),
                  textAlign: TextAlign.start,
                ),
              ));
        }).toList(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        onSaved: onSaved,
        onChanged: onChanged);
  }
}
