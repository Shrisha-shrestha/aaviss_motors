import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageFormField extends FormField<File> {
  CustomImageFormField(
      {Key? key,
      required String? fieldname,
      required GlobalKey<FormState> formkey,
      FormFieldSetter<File?>? onSaved,
      File? initialValue,
      bool autoValidate = true,
      bool enabled = true})
      : super(
            key: key,
            validator: (value) =>
                value == null ? '$fieldname \nis empty' : null,
            onSaved: onSaved,
            initialValue: initialValue,
            builder: (FormFieldState<File> state) {
              Widget content = DottedBorder(
                color: state.hasError ? Colors.red : Colors.grey,
                dashPattern: const [4, 4],
                strokeWidth: 2,
                child: Container(
                    height: 130,
                    width: 143,
                    decoration: state.value != null
                        ? BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(state.value!), //file
                                fit: BoxFit.cover))
                        : BoxDecoration(
                            color: Colors.white,
                          ),
                    child: IconButton(
                      onPressed: () async {
                        final _picker = ImagePicker();
                        var image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        dynamic selectedImage = File(image!.path);
                        state.didChange(selectedImage);
                        //formkey.currentState!.validate();
                      },
                      icon: Icon(
                        Icons.upload,
                        color: state.value == null
                            ? Colors.grey
                            : Color.fromRGBO(140, 187, 232, 1),
                        size: 30.0,
                      ),
                    )),
              );

              if (state.hasError) {
                return Column(
                  children: <Widget>[
                    content,
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        state.errorText!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.red),
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: <Widget>[
                    content,
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        fieldname!,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                );
              }
            });
}
