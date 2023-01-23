import 'package:aaviss_motors/screens/search_detail.dart';
import 'package:aaviss_motors/screens/vehicle_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aaviss_motors/models/storevehicleinfo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? fullname;
  String? address;
  int? contact;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Store store = Store();
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
          leading: Transform.translate(
            offset: const Offset(-15, 0),
          ),
          titleSpacing: -30,
          centerTitle: false,
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
                  child: SingleChildScrollView(
                    child: Form(
                      autovalidateMode: _autoValidate,
                      key: _formkey,
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
                                      '1',
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
                                'Personnel Information',
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Text(
                              'Personnel data',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          TextFormField(
                            onSaved: (String? value) {
                              store.full_name = value;
                            },
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 18.0),
                            validator: (val) => val!.isEmpty
                                ? 'Enter your full name please.'
                                : null,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              labelStyle: Theme.of(context).textTheme.caption,
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey), //<-- SEE HERE
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            onSaved: (String? value) {
                              store.address = value;
                            },
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 18.0),
                            validator: (val) => val!.isEmpty
                                ? 'Enter your address please.'
                                : null,
                            decoration: InputDecoration(
                                labelText: 'Address',
                                labelStyle: Theme.of(context).textTheme.caption,
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (String? value) {
                              store.phone_no = value;
                            },
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 18.0),
                            validator: (val) {
                              RegExp regExp = RegExp(
                                  r'(?:\(?\+977\)?)?[9][6-9]\d{8}|01[-]?[0-9]{7}');
                              if (val!.isEmpty) {
                                return 'Enter your contact number please.';
                              } else if (regExp.hasMatch(val)) {
                                return null;
                              } else {
                                return 'Phone No. is not valid';
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Contact Number',
                              labelStyle: Theme.of(context).textTheme.caption,
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();
                                    if (kDebugMode) {
                                      print('Client Side Validated');
                                    }
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => VehicleInfo(
                                                title: widget.title,
                                                store: store)));
                                  } else {
                                    setState(() => _autoValidate =
                                        AutovalidateMode.always);
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
                                child: Text('Next',
                                    style: Theme.of(context).textTheme.button)),
                          ),
                        ],
                      ),
                    ),
                  ),
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
