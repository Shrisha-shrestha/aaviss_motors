// ignore_for_file: deprecated_member_use

import 'package:aaviss_motors/screens/confirmation.dart';
import 'package:aaviss_motors/screens/search_detail.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/storevehicleinfo.dart';
import '../widgets/imageformfield.dart';

class LegalInfo extends StatefulWidget {
  const LegalInfo(
      {super.key,
      required this.title,
      required this.store,
      required this.bvinfoAPI});
  final String title;
  final Store store;
  final B_V_fromAPI bvinfoAPI;
  @override
  State<LegalInfo> createState() => _LegalInfoState();
}

class _LegalInfoState extends State<LegalInfo> {
  int? groupval;
  bool _isvisible1 = false, _isvisible2 = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  File? image1, image2, image3, image4, image5;
  String errortxt = '';
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  // final _picker = ImagePicker();
  // Future<File?> getImage() async {
  //   final pickedFile = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 1,
  //   );
  //   if (pickedFile != null) {
  //     return File(pickedFile.path);
  //   } else {
  //     if (kDebugMode) {
  //       print('no image selected');
  //     }
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(widget.title, style: Theme.of(context).textTheme.headline5),
          titleSpacing: -30,
          toolbarHeight: 108.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: IconButton(
                  icon: SvgPicture.asset('assets/search.svg',
                      semanticsLabel: 'Search'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SearchDetail(title: widget.title)));
                  }),
            ),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 27.0, right: 29.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Resale Value Calculator ',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 34),
                  child: Text(
                    'Fill the form below to know resale\nvalue of your vehicle',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Expanded(
                  child: Form(
                      autovalidateMode: _autoValidate,
                      key: _formkey,
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                  height: 20.0,
                                  width: 20.0,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: const Center(
                                    child: Text(
                                      '3',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: 12.0),
                                    ),
                                  )),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                'Legal Information',
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              'Citizenship / Pan',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                  value: 1,
                                  groupValue: groupval,
                                  onChanged: (value) {
                                    setState(() {
                                      groupval = value;
                                      widget.store.nid_type = 'Citizenship';
                                      widget.store.card_type_radio = 1;
                                      _isvisible2 = false;
                                      _isvisible1 = true;
                                    });
                                  }),
                              Text(
                                'Citizenship',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              const SizedBox(
                                width: 40.0,
                              ),
                              Radio(
                                  value: 2,
                                  groupValue: groupval,
                                  onChanged: (value) {
                                    setState(() {
                                      groupval = value;
                                      widget.store.nid_type = 'Pan';
                                      widget.store.card_type_radio = 2;
                                      _isvisible2 = true;
                                      _isvisible1 = false;
                                    });
                                  }),
                              Text(
                                'Pan',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          SizedBox(
                              child: Text(
                            errortxt,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.red),
                          )),
                          Visibility(
                            visible: _isvisible1,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onSaved: (String? value) {
                                widget.store.citizenship_no = value;
                              },
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 18.0),
                              validator: (value) => value!.isEmpty
                                  ? 'Enter your Citizenship number please.'
                                  : null,
                              decoration: InputDecoration(
                                labelText: 'Citizenship Number',
                                labelStyle: Theme.of(context).textTheme.caption,
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _isvisible2,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onSaved: (String? value) {
                                widget.store.pan_no = value;
                              },
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 18.0),
                              validator: (value) => value!.isEmpty
                                  ? 'Enter your Pan number please.'
                                  : null,
                              decoration: InputDecoration(
                                labelText: 'Pan Number',
                                labelStyle: Theme.of(context).textTheme.caption,
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 45.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CustomImageFormField(
                                  formkey: _formkey,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  fieldname:
                                      '${widget.store.nid_type ?? 'Card'} front page',
                                  onSaved: ((newValue) {
                                    setState(() {
                                      widget.store.img1 = newValue;
                                    });
                                  })),
                              CustomImageFormField(
                                  formkey: _formkey,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  fieldname:
                                      '${widget.store.nid_type ?? 'Card'} back page',
                                  onSaved: ((newValue) {
                                    setState(() {
                                      widget.store.img2 = newValue;
                                    });
                                  })),
                            ],
                          ),
                          const SizedBox(
                            height: 23.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CustomImageFormField(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  formkey: _formkey,
                                  fieldname: 'Billbook main page',
                                  onSaved: ((newValue) {
                                    setState(() {
                                      widget.store.img3 = newValue;
                                    });
                                  })),
                              CustomImageFormField(
                                  formkey: _formkey,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  fieldname: 'Billbook renewal page',
                                  onSaved: ((newValue) {
                                    setState(() {
                                      widget.store.img4 = newValue;
                                    });
                                  })),
                            ],
                          ),
                          const SizedBox(
                            height: 23.0,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CustomImageFormField(
                                width: MediaQuery.of(context).size.width * 0.4,
                                formkey: _formkey,
                                fieldname:
                                    'BIllbook tax last renewal date page',
                                onSaved: ((newValue) {
                                  setState(() {
                                    widget.store.img5 = newValue;
                                  });
                                })),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                              side: BorderSide(
                                                  color: Colors.grey)))),
                                  child: Text('Back',
                                      style: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .copyWith(color: Colors.grey))),
                              const SizedBox(
                                width: 10.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  // if (kDebugMode) {
                                  //   print(widget.store.img1);
                                  //   print(widget.store.img2);
                                  //   print(widget.store.img3);
                                  //   print(widget.store.img4);
                                  //   print(widget.store.img5);
                                  //   print(widget.store.nid_no);
                                  //   print(widget.store.no_of_transfer);
                                  //   print(widget.store.purchase_year);
                                  //   print(widget.store.no_of_seats);
                                  //   print(widget.store.manufacture_year);
                                  //   print(widget.store.engine_no);
                                  //   print(widget.store.vehicle_name_id);
                                  //   print(widget.store.brand_id);
                                  //   print(widget.store.nid_type);
                                  //   print(widget.store.vehicle_no);
                                  //   print(widget.store.vehicle_type);
                                  //   print(widget.store.color);
                                  //   print(widget.store.phone_no);
                                  //   print(widget.store.address);
                                  //   print(widget.store.full_name);
                                  // }
                                  if (groupval == null) {
                                    setState(() {
                                      errortxt = 'Please Select one';
                                    });
                                  } else {
                                    setState(() {
                                      errortxt = '';
                                    });

                                    if (_formkey.currentState!.validate()) {
                                      _formkey.currentState!.save();
                                      if (kDebugMode) {
                                        print('Client Side Validated');
                                      }
                                      //print(widget.bvinfoAPI.brandlist![0].id);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Confirmation(
                                                    title: widget.title,
                                                    store: widget.store,
                                                    bvinfoAPI: widget.bvinfoAPI,
                                                  )));
                                    } else {
                                      setState(() {
                                        _autoValidate = AutovalidateMode.always;
                                      });
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero,
                                            side: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary)))),
                                child: Text('Finish',
                                    style: Theme.of(context).textTheme.button),
                              ),
                            ],
                          ),
                        ],
                      ))),
                ),
                SizedBox(
                  height: 34.0,
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
