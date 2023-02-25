import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:aaviss_motors/screens/search_detail.dart';
import 'package:aaviss_motors/screens/vehicle_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aaviss_motors/models/storevehicleinfo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../models/confirmation_response.dart';
import '../widgets/dropdown.dart';
import 'finish_screen.dart';
import 'package:flutter/foundation.dart';

class Confirmation extends StatefulWidget {
  const Confirmation(
      {super.key,
      required this.title,
      required this.store,
      required this.bvinfoAPI});
  final String title;
  final Store store;
  final B_V_fromAPI bvinfoAPI;
  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  Store store = Store();
  int? val1, val2, val3;
  bool _isvisible1 = false,
      _isvisible2 = false,
      _isvisible3 = false,
      _isvisible4 = false,
      _isvisible5 = false;

  @override
  Widget build(BuildContext context) {
    val1 = widget.store.major_accident!.toLowerCase() == "yes" ? 1 : 2;
    val2 = widget.store.service_history!.toLowerCase() == "yes" ? 1 : 2;
    val3 = widget.store.vehicle_type!.toLowerCase() == "private" ? 1 : 2;
    if (widget.store.manufacture_year != null) {
      _isvisible5 = true;
    }

    if (widget.store.number_plate_radio == 1) {
      _isvisible1 = true;
    } else if (widget.store.number_plate_radio == 2) {
      _isvisible2 = true;
    }

    if (widget.store.card_type_radio == 1) {
      _isvisible3 = true;
      widget.store.nid_no = widget.store.citizenship_no;
    } else if (widget.store.card_type_radio == 2) {
      _isvisible4 = true;
      widget.store.nid_no = widget.store.pan_no;
    }

    String? brand = widget.bvinfoAPI.blist![int.parse(widget.store.brand_id!)];
    String? vehicle =
        widget.bvinfoAPI.velist![int.parse(widget.store.vehicle_name_id!)];
    String? variant =
        widget.bvinfoAPI.valist![int.parse(widget.store.variant_id!)];

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VehicleInfo(
                        title: widget.title,
                      )));
            },
            child: Text(widget.title,
                style: Theme.of(context).textTheme.headline5)),
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
                    builder: (context) => SearchDetail(title: widget.title)));
              },
            ),
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
                padding: const EdgeInsets.only(top: 14),
                child: Text(
                  'Confirmation',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 23.0),
                child: Text(
                  'Confirm all the data before submitting',
                  style: Theme.of(context).textTheme.subtitle2!,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'Vehicle Information',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Text(
                      'Vehicle Type',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Row(
                      children: <Widget>[
                        Radio<int>(
                            value: 1,
                            groupValue: val3,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            onChanged: (int? value) {}),
                        Text("Private",
                            style: Theme.of(context).textTheme.caption),
                        const SizedBox(
                          width: 72.0,
                        ),
                        Radio<int>(
                            value: 2,
                            groupValue: val3,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            onChanged: (int? value) {}),
                        Text("Public",
                            style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                    Text(
                      'Number Plate',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Row(
                      children: <Widget>[
                        Radio<int>(
                            value: 1,
                            groupValue: widget.store.number_plate_radio,
                            toggleable: false,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            onChanged: (int? value) {}),
                        Text("Zonal",
                            style: Theme.of(context).textTheme.caption),
                        const SizedBox(
                          width: 80.0,
                        ),
                        Radio<int>(
                            value: 2,
                            groupValue: widget.store.number_plate_radio,
                            toggleable: false,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            onChanged: (int? value) {}),
                        Text("Provincal",
                            style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                    Visibility(
                      visible: _isvisible1,
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CustomDropdownwidget(
                                  validator: (val) =>
                                      val?.isEmpty == true || val == null
                                          ? 'Required!'
                                          : null,
                                  droplabel: 'Zonal Code',
                                  list: const [],
                                  dropdownvalue: widget.store.zonal_code,
                                  onChanged: (String? value) {},
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 14.0),
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: 45.0,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Lot Number',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(fontSize: 9.0)),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Center(
                                      child: Text(
                                        widget.store.lot_number!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(fontSize: 16.5),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CustomDropdownwidget(
                                  validator: (val) =>
                                      val?.isEmpty == true || val == null
                                          ? 'Required!'
                                          : null,
                                  droplabel: 'Vehicle Type',
                                  list: const [],
                                  dropdownvalue: widget.store.v_type,
                                  onChanged: (String? value) {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 14.0),
                            width: MediaQuery.of(context).size.width * 0.26,
                            height: 45.0,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Vehicle Number',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontSize: 9.0)),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Center(
                                  child: Text(
                                    widget.store.v_no!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontSize: 16.5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _isvisible2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: CustomDropdownwidget(
                                    validator: (val) =>
                                        val?.isEmpty == true || val == null
                                            ? 'Required!'
                                            : null,
                                    droplabel: 'Province',
                                    list: const [],
                                    dropdownvalue: widget.store.province,
                                    onChanged: null),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 14.0),
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 45.0,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Office Code',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(fontSize: 9.0)),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Center(
                                      child: Text(
                                        widget.store.office_code ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(fontSize: 16.5),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 14.0),
                                width: MediaQuery.of(context).size.width * 0.26,
                                height: 45.0,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Lot Number',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(fontSize: 9.0)),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Center(
                                      child: Text(
                                        widget.store.lot_number!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(fontSize: 16.5),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.26,
                                child: CustomDropdownwidget(
                                    validator: (val) =>
                                        val?.isEmpty == true || val == null
                                            ? 'Required!'
                                            : null,
                                    droplabel: 'Symbol',
                                    list: const [],
                                    dropdownvalue: widget.store.symbol,
                                    onChanged: null),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 14.0),
                                width: MediaQuery.of(context).size.width * 0.26,
                                height: 45.0,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Vehicle Number',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(fontSize: 9.0)),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Center(
                                      child: Text(
                                        widget.store.v_no!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(fontSize: 16.5),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          widget.store.number_plate_radio == 1
                              ? '${widget.store.zonal_code ?? ''}-${widget.store.lot_number ?? ''}-${widget.store.v_type ?? ''}-${widget.store.v_no ?? ''}'
                              : '${widget.store.province ?? ''}-${widget.store.office_code ?? ''}-${widget.store.lot_number ?? ''}-${widget.store.symbol ?? ''}-${widget.store.v_no ?? ''}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      'Major Accident',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Row(
                      children: <Widget>[
                        Radio<int>(
                            value: 1,
                            groupValue: val1,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            onChanged: (int? value) {}),
                        Text("Yes", style: Theme.of(context).textTheme.caption),
                        const SizedBox(
                          width: 88.0,
                        ),
                        Radio<int>(
                            value: 2,
                            groupValue: val1,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            onChanged: (int? value) {}),
                        Text("No", style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                    Text(
                      'Service History',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Row(
                      children: <Widget>[
                        Radio<int>(
                            value: 1,
                            groupValue: val2,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            onChanged: (int? value) {}),
                        Text("Yes", style: Theme.of(context).textTheme.caption),
                        SizedBox(width: 88.0),
                        Radio<int>(
                            value: 2,
                            groupValue: val2,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            onChanged: (int? value) {}),
                        Text("No", style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          'Name of Brand : $brand',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          'Name of Vehicle : $vehicle',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          'Name of Variant : $variant',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          'Engine No. : ${widget.store.engine_no}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Visibility(
                      visible: _isvisible5,
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(8.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                              ),
                              child: Text(
                                'Manufacture Year : ${widget.store.manufacture_year}',
                                style: Theme.of(context).textTheme.subtitle2,
                              )),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          'Color : ${widget.store.color}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          'No. of Seat : ${widget.store.no_of_seats}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          'Purchase Year : ${widget.store.purchase_year}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          'No. of Past owners : ${widget.store.no_of_transfer}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          'Mileage : ${widget.store.kilometer}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      'Personnel Data',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          'Full Name : ${widget.store.full_name}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          'Address : ${widget.store.address}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Text(
                          'Contact Number : ${widget.store.phone_no}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 10),
                      child: Text(
                        'Citizenship / Pan',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: 1,
                            toggleable: false,
                            groupValue: widget.store.card_type_radio,
                            onChanged: (value) {}),
                        Text(
                          'Citizenship',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        const SizedBox(
                          width: 40.0,
                        ),
                        Radio(
                            value: 2,
                            toggleable: false,
                            groupValue: widget.store.card_type_radio,
                            onChanged: (value) {}),
                        Text(
                          'Pan',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Visibility(
                          visible: _isvisible3,
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                              ),
                              child: Text(
                                'Citizenship Number: ${widget.store.citizenship_no}',
                                style: Theme.of(context).textTheme.subtitle2,
                              )),
                        ),
                        Visibility(
                          visible: _isvisible4,
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                              ),
                              child: Text(
                                'Pan Number : ${widget.store.pan_no}',
                                style: Theme.of(context).textTheme.subtitle2,
                              )),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: [
                                DottedBorder(
                                  dashPattern: const [4, 4],
                                  strokeWidth: 2,
                                  child: SizedBox(
                                    height: 130,
                                    width: MediaQuery.of(context).size.width *
                                        0.38,
                                    child: Image.file(
                                      File(widget.store.img1!.path).absolute,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    widget.store.card_type_radio == 1
                                        ? 'Citizenship card '
                                        : 'Pan card ',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              ],
                            ),
                            // Column(
                            //   children: [
                            // DottedBorder(
                            //   dashPattern: const [4, 4],
                            //   strokeWidth: 2,
                            //   child: SizedBox(
                            //     height: 130,
                            //     width:
                            //         MediaQuery.of(context).size.width * 0.4,
                            //     child: Image.file(
                            //       File(widget.store.img2!.path).absolute,
                            //       height: 130,
                            //       width: MediaQuery.of(context).size.width *
                            //           0.4,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 8.0),
                            //   child: Text(
                            //     widget.store.card_type_radio == 1
                            //         ? 'Citizenship back page'
                            //         : 'Pan back page',
                            //     style: Theme.of(context).textTheme.caption,
                            //   ),
                            // ),
                            //   ],
                            // ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25.0),
                            child: Text(
                              'Bill Book Information',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: [
                                DottedBorder(
                                  dashPattern: const [4, 4],
                                  strokeWidth: 2,
                                  child: SizedBox(
                                    height: 130,
                                    width: MediaQuery.of(context).size.width *
                                        0.38,
                                    child: Image.file(
                                      File(widget.store.img3!.path).absolute,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Billbook photo page\n',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                DottedBorder(
                                  dashPattern: const [4, 4],
                                  strokeWidth: 2,
                                  child: SizedBox(
                                    height: 130,
                                    width: MediaQuery.of(context).size.width *
                                        0.38,
                                    child: Image.file(
                                      File(widget.store.img5!.path).absolute,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'Billbook tax last \nrenewal date page',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              ],
                            ),
                            // Column(
                            //   children: [
                            // DottedBorder(
                            //   dashPattern: const [4, 4],
                            //   strokeWidth: 2,
                            //   child: SizedBox(
                            //     height: 130,
                            //     width:
                            //         MediaQuery.of(context).size.width * 0.4,
                            //     child: Image.file(
                            //       File(widget.store.img4!.path).absolute,
                            //       height: 130,
                            //       width: MediaQuery.of(context).size.width *
                            //           0.4,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 8.0),
                            //   child: Text(
                            //     'Billbook renewal page',
                            //     style: Theme.of(context).textTheme.caption,
                            //   ),
                            // ),
                            //   ],
                            // ),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 23.0,
                        // ),
                        // Column(
                        //   children: [
                        //     DottedBorder(
                        //       dashPattern: const [4, 4],
                        //       strokeWidth: 2,
                        //       child: SizedBox(
                        //         height: 130,
                        //         width: MediaQuery.of(context).size.width * 0.4,
                        //         child: Image.file(
                        //           File(widget.store.img5!.path).absolute,
                        //           height: 130,
                        //           width:
                        //               MediaQuery.of(context).size.width * 0.4,
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(top: 8.0),
                        //       child: Text(
                        //         'Billbook tax last renewal date page',
                        //         style: Theme.of(context).textTheme.caption,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 30.0,
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
                                        MaterialStateProperty.all(Colors.white),
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
                                child: Text('Submit',
                                    style: Theme.of(context).textTheme.button),
                                onPressed: () async {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      barrierColor: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.2),
                                      builder: (ctx) {
                                        return Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            height: 80,
                                            width: 80,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                            ),
                                          ),
                                        );
                                      });

                                  // if (kDebugMode) {
                                  //   print(widget.store.kilometer);
                                  // }
                                  var uri = Uri.parse(
                                      'https://cms.aavissmotors.com/api/v1/save-vehicle');
                                  var request =
                                      http.MultipartRequest('POST', uri);
                                  request.headers.addAll({
                                    "Content-Type": "multipart/form-data",
                                    "Accept": "application/json",
                                  });
                                  request.fields.addAll({
                                    'full_name': '${widget.store.full_name}',
                                    'address': '${widget.store.address}',
                                    'phone_no': '${widget.store.phone_no}',
                                    'brand_id': '${widget.store.brand_id}',
                                    'vehicle_name_id':
                                        '${widget.store.vehicle_name_id}',
                                    'engine_no': '${widget.store.engine_no}',
                                    'manufacture_year':
                                        '${widget.store.manufacture_year ?? ''}',
                                    'color': '${widget.store.color}',
                                    'no_of_seats':
                                        '${widget.store.no_of_seats}',
                                    'purchase_year':
                                        '${widget.store.purchase_year}',
                                    'no_of_transfer':
                                        '${widget.store.no_of_transfer}',
                                    'vehicle_type':
                                        '${widget.store.vehicle_type}',
                                    'vehicle_no': '${widget.store.vehicle_no}',
                                    'nid_type': '${widget.store.nid_type}',
                                    'nid_no': '${widget.store.nid_no}',
                                    'variant_id': '${widget.store.variant_id}',
                                    'kilometer': '${widget.store.kilometer}',
                                    'major_accident':
                                        '${widget.store.major_accident}',
                                    'service_history':
                                        '${widget.store.service_history}'
                                  });
                                  request.files.add(
                                      await http.MultipartFile.fromPath(
                                          "nid_front",
                                          widget.store.img1!.path));

                                  request.files.add(
                                      await http.MultipartFile.fromPath(
                                          "bill_book_main_page",
                                          widget.store.img3!.path));

                                  request.files.add(
                                      await http.MultipartFile.fromPath(
                                          "bill_book_tax_renewed_date_page",
                                          widget.store.img5!.path));

                                  // request.files.add(
                                  //     await http.MultipartFile.fromPath(
                                  //         "nid_back", widget.store.img2!.path));
                                  // request.files.add(
                                  //     await http.MultipartFile.fromPath(
                                  //         "bill_book_renewal_page",
                                  //         widget.store.img4!.path));

                                  var response = await request.send();
                                  Navigator.pop(context);
                                  print(response.statusCode);
                                  Map<String, dynamic> valueMap = json.decode(
                                      await response.stream.bytesToString());
                                  StoreResponseModel responseModel =
                                      StoreResponseModel.fromJson(valueMap);
                                  Fluttertoast.showToast(
                                      msg: responseModel.message == ''
                                          ? 'Error occured\nPlease try again'
                                          : responseModel.message.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      textColor: Colors.black);
                                  // final snackBar1 = SnackBar(
                                  //     backgroundColor:
                                  //         Theme.of(context).colorScheme.primary,
                                  //     content: Text(responseModel.message == ''
                                  //         ? 'Error occured\nPlease try again'
                                  //         : responseModel.message.toString()));
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(snackBar1);

                                  if (response.statusCode == 200) {
                                    print('Sent');
                                    if (responseModel.status == true) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FinishScreen(
                                                    title: widget.title,
                                                  )));
                                    }
                                  }
                                })
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
              ),
              SizedBox(
                height: 34.0,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
