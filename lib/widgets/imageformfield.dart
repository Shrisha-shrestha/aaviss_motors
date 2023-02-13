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
      double? width,
      required BuildContext ctx,
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
                    width: width!,
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
                        //dynamic selectedImage = popup(ctx);
                        File? si;

                        await showDialog(
                            barrierColor:
                                Theme.of(ctx).primaryColor.withOpacity(0.2),
                            context: ctx,
                            builder: (context) {
                              return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  title: Text(
                                    'Choose one',
                                    style: Theme.of(ctx)
                                        .textTheme
                                        .headline5!
                                        .copyWith(fontSize: 20),
                                  ),
                                  content: SizedBox(
                                    height: 120,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap: () async {
                                            si = await _openCamera(context);

                                            Navigator.pop(context);
                                          },
                                          leading: Icon(Icons.camera),
                                          title: Text('From camera'),
                                        ),
                                        ListTile(
                                            onTap: () async {
                                              si = await _openGallery(context);
                                              Navigator.pop(context);
                                            },
                                            leading: Icon(Icons.photo),
                                            title: Text('From Gallery')),
                                      ],
                                    ),
                                  ));
                            });
                        state.didChange(si);

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

Future<File?> _openGallery(BuildContext context) async {
  final _picker = ImagePicker();
  var image =
      await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20);
  File selectedImage = File(image!.path).absolute;
  print(selectedImage);
  return selectedImage;
}

Future<File?> _openCamera(BuildContext context) async {
  final _picker = ImagePicker();
  var image =
      await _picker.pickImage(source: ImageSource.camera, imageQuality: 20);
  File selectedImage = File(image!.path).absolute;
  return selectedImage;
}
