import 'package:flutter/material.dart';

bool tap = false;

class CustomRadioFormField extends FormField<int> {
  CustomRadioFormField({
    Key? key,
    required String? fieldname1,
    required String? fieldname2,
    required GlobalKey<FormState> formkey,
    required BuildContext ctx,
    int? grpvalue,
    FormFieldSetter<int?>? onSaved,
    FormFieldSetter<int?>? onChanged,
  }) : super(
            key: key,
            validator: (value) {
              if (value == null) {
                return 'Please Choose One ';
              } else {
                return null;
              }
            },
            onSaved: onSaved,
            builder: (FormFieldState<int> state) {
              Widget content = Row(
                children: [
                  Radio<int>(
                      value: 1,
                      fillColor: MaterialStateColor.resolveWith((states) =>
                          state.hasError
                              ? Colors.red
                              : Theme.of(ctx).colorScheme.secondary),
                      groupValue: grpvalue,
                      onChanged: (value) {
                        state.didChange(value);
                        onChanged!(value);
                      }),
                  SizedBox(
                    width: MediaQuery.of(ctx).size.width * 0.25,
                    child: Text(fieldname1!,
                        style: Theme.of(ctx).textTheme.caption),
                  ),
                  Radio<int>(
                      value: 2,
                      fillColor: MaterialStateProperty.all(state.hasError
                          ? Colors.red
                          : Theme.of(ctx).colorScheme.secondary),
                      groupValue: grpvalue,
                      onChanged: (value) {
                        state.didChange(value);
                        onChanged!(value);
                      }),
                  SizedBox(
                    width: MediaQuery.of(ctx).size.width * 0.25,
                    child: Text(fieldname2!,
                        style: Theme.of(ctx).textTheme.caption),
                  ),
                ],
              );

              if (state.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: <Widget>[
                      content,
                    ]),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      state.errorText.toString(),
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.normal,
                          fontSize: 10.0),
                    ),
                  ],
                );
              } else {
                return Row(
                  children: <Widget>[
                    Row(
                      children: [
                        content,
                      ],
                    ),
                  ],
                );
              }
            });
}
