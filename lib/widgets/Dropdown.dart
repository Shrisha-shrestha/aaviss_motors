import 'package:flutter/material.dart';
class CustomDropdownwidget extends StatelessWidget {
  final List<String> list;
  final String droplabel;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  const CustomDropdownwidget({
    super.key,
    required this.list,
    required this.droplabel,
    this.onSaved,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Form(
      child: DropdownButtonFormField<String?>(
          validator: (val) => val!.isEmpty ? 'Required!' : null,
          disabledHint: Text(
            'Please Wait...',
            style: Theme.of(context).textTheme.caption,
          ),
          menuMaxHeight: 160.0,
          decoration: InputDecoration(
            labelText: droplabel,
            labelStyle: Theme.of(context).textTheme.caption,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
            ),
          ),
          items: list.map((e) {
            return DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 15.0),
                  textAlign: TextAlign.start,
                ));
          }).toList(),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.grey,
          ),
          onSaved: onSaved,
          onChanged: onChanged),
    );
  }
}
