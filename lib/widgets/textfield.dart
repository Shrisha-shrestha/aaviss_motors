import 'package:flutter/material.dart';

import '../models/storevehicleinfo.dart';

class customDropdownwidget extends StatelessWidget {
  final List<String> list;
  final String droplabel;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  customDropdownwidget({
    super.key,
    required this.list,
    required this.droplabel,
    this.onSaved,
    this.onChanged,
  });
  @override
  String? dropdownvalue;
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onSaved: (String? value) {},
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 18.0),
        validator: (val) => val!.isEmpty ? 'Required!' : null,
        decoration: InputDecoration(
          labelText: 'Zonal Code',
          labelStyle: Theme.of(context).textTheme.caption,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
          ),
        ),
      ),
    );
  }
}
