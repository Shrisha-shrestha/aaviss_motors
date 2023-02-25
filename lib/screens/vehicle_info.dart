import 'package:aaviss_motors/models/getvariants.dart';
import 'package:aaviss_motors/screens/legal_info.dart';
import 'package:aaviss_motors/screens/personnel_info.dart';
import 'package:aaviss_motors/screens/search_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../API/API_connection.dart';
import '../models/getbrand.dart';
import '../models/getvehiclename.dart';
import '../models/searchvehicle.dart';
import '../models/storevehicleinfo.dart';
import '../widgets/dropdown.dart';
import '../widgets/radioformfield.dart';

class VehicleInfo extends StatefulWidget {
  const VehicleInfo({
    super.key,
    required this.title,
    //required this.store
  });
  final String title;
  //final Store store;
  @override
  State<VehicleInfo> createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
  int? val1, val2, val3, val4;
  List<String> prov = [
    'Province No.1',
    'Madhesh province',
    'Bagmati province ',
    'Gandaki province',
    'Lumbini province',
    'Karnali province',
    'Sudurpashchim province'
  ];
  dynamic val;
  List<String> years = [], test = [''];
  int? dropdownvalue1, dropdownvalue2, dropdownvalue3;
  String? dropdownvalue, dropdownvalue4, dropdownvalue5;
  String? d1, d2, d3, d4;
  final GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formkey2 = GlobalKey<FormState>();

  bool _isvisible1 = false, _isvisible2 = false;
  String? errorinaccident = '',
      errorinhistory = '',
      errorinpurchase = '',
      errorinvehicletype = '',
      errorinnumbreplate = '';
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  Future<B_V_fromAPI>? future1, future2, future3;
  B_V_fromAPI bfa = B_V_fromAPI();
  bool futureresult1 = false, futureresult2 = false, futureresult3 = false;
  final Store store = Store();

  Future<B_V_fromAPI>? getb() async {
    dynamic brandlist;
    APIService apiService = APIService();
    int? len;
    List<String>? brands = [];
    List<int>? brandsId = [];
    await apiService.getbrand().then((value) {
      brandlist = value!.outerdata!.brands!.innerdata!;
      len = value.outerdata!.brands!.total;
    });
    for (int i = 0; i < len!; i++) {
      brands.add("${brandlist[i].name}");
      brandsId.add(brandlist[i].id);
    }
    final theMap1 = Map.fromIterables(brandsId, brands);
    bfa.blist = theMap1;
    bfa.brandlist = brandlist;
    return bfa;
  }

  Future<B_V_fromAPI>? getve(String brand_id) async {
    //print('brand_id : ${brand_id.toString()}');
    dynamic vehiclelist;
    List<innerdata> newvehiclelist = [];
    int? len;
    List<String>? vehicles = [];
    List<int>? vehiclesId = [];
    APIService apiService = APIService();

    await apiService.getvehicle().then((value) {
      vehiclelist = value.data!.vehicleNames!.data!;
      len = value.data!.vehicleNames!.total!;
    });

    for (int i = 0; i < len!; i++) {
      vehicles.add("${vehiclelist[i].vehicleName}");
      vehiclesId.add(vehiclelist[i].id);
      if (vehiclelist[i].brandId.toString() == brand_id) {
        //print('index = ${vehiclelist[i].id}');
        newvehiclelist.add(vehiclelist[i]);
      }
    }
    final theMap2 = Map.fromIterables(vehiclesId, vehicles);
    bfa.velist = theMap2;
    if (newvehiclelist.isEmpty) {
      bfa.vehiclelist = vehiclelist;
    } else {
      bfa.vehiclelist = newvehiclelist;
    }
    return bfa;
  }

  Future<B_V_fromAPI>? getva(String vehicle_id) async {
    dynamic variantlist;
    List<inner_data> newvariantlist = [];
    int? len;
    List<String>? variants = [];
    List<int>? variantId = [];
    APIService apiService = APIService();
    await apiService.getvariant().then((value) {
      variantlist = value.data!.variants!.data!;
      len = value.data!.variants!.total!;
    });
    for (int i = 0; i < len!; i++) {
      variants.add("${variantlist[i].variantName}");
      variantId.add(variantlist[i].id);
      if (variantlist[i].vehicleNameId.toString() == vehicle_id) {
        //print('index = ${variantlist[i].id}');
        newvariantlist.add(variantlist[i]);
      }
    }
    final theMap3 = Map.fromIterables(variantId, variants);
    bfa.valist = theMap3;

    if (newvariantlist.isEmpty) {
      bfa.variantlist = variantlist;
    } else {
      bfa.variantlist = newvariantlist;
    }
    return bfa;
  }

  @override
  void initState() {
    int now = DateTime.now().year;
    for (now; now >= 1960; now--) {
      years.add(now.toString());
    }
    future1 = getb();
    future2 = getve('-1');
    future3 = getva('-1');
    // store.brand_id = '-1';
    // store.vehicle_name_id = '-1';
    super.initState();
  }

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
            offset: Offset(-15, 0),
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                'Vehicle Information',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 30.0, bottom: 20.0),
                            child: Text(
                              'Vehicle Information',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          Form(
                            key: formkey1,
                            autovalidateMode: _autoValidate,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Vehicle Type*',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                CustomRadioFormField(
                                  fieldname1: 'Private',
                                  fieldname2: 'Public',
                                  formkey: formkey1,
                                  grpvalue: val3,
                                  ctx: context,
                                  onChanged: (newValue) {
                                    setState(() {
                                      val3 = newValue;
                                      store.vehicle_type =
                                          val3 == 1 ? 'private' : 'public';
                                      store.vehicle_type_radio = val3;
                                    });
                                  },
                                  onSaved: (Finalvalue) {
                                    print('value: $val3');
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                // Row(
                                //   children: <Widget>[
                                //     Radio<int>(
                                //         value: 1,
                                //         groupValue: val3,
                                //         activeColor: Theme.of(context)
                                //             .colorScheme
                                //             .secondary,
                                //         onChanged: (int? value) {
                                //           setState(() {
                                //             val3 = value;
                                //             store.vehicle_type = 'private';
                                //             store.vehicle_type_radio = 1;
                                //           });
                                //         }),
                                //     Text("Private",
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .caption),
                                //     const SizedBox(
                                //       width: 72.0,
                                //     ),
                                //     Radio<int>(
                                //         value: 2,
                                //         groupValue: val3,
                                //         activeColor: Theme.of(context)
                                //             .colorScheme
                                //             .secondary,
                                //         onChanged: (int? value) {
                                //           setState(() {
                                //             val3 = value;
                                //             store.vehicle_type = 'public';
                                //             store.vehicle_type_radio = 2;
                                //           });
                                //         }),
                                //     Text("Public",
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .caption),
                                //   ],
                                // ),
                                // SizedBox(
                                //     child: Text(
                                //   '$errorinvehicletype',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .caption!
                                //       .copyWith(color: Colors.red),
                                // )),
                                Text(
                                  'Number Plate*',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                CustomRadioFormField(
                                  fieldname1: 'Zonal',
                                  fieldname2: 'Provincal',
                                  formkey: formkey1,
                                  grpvalue: val4,
                                  ctx: context,
                                  onChanged: (newValue) {
                                    setState(() {
                                      val4 = newValue;
                                      _isvisible2 = val4 == 2 ? true : false;
                                      _isvisible1 = val4 == 1 ? true : false;
                                      store.number_plate_radio = val4;
                                    });
                                  },
                                  onSaved: (Finalvalue) {
                                    print('value: $val4');
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                // Row(
                                //   children: <Widget>[
                                //     Radio<int>(
                                //         value: 1,
                                //         groupValue: val4,
                                //         activeColor: Theme.of(context)
                                //             .colorScheme
                                //             .secondary,
                                //         onChanged: (int? value) {
                                //           setState(() {
                                //             val4 = value;
                                //             _isvisible2 = false;
                                //             _isvisible1 = true;
                                //             store.number_plate_radio = 1;
                                //           });
                                //         }),
                                //     Text("Zonal",
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .caption),
                                //     const SizedBox(
                                //       width: 78.0,
                                //     ),
                                //     Radio<int>(
                                //         value: 2,
                                //         groupValue: val4,
                                //         activeColor: Theme.of(context)
                                //             .colorScheme
                                //             .secondary,
                                //         onChanged: (int? value) {
                                //           setState(() {
                                //             val4 = value;
                                //             _isvisible2 = true;
                                //             _isvisible1 = false;
                                //             store.number_plate_radio = 2;
                                //           });
                                //         }),
                                //     Text("Provincal",
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .caption),
                                //   ],
                                // ),
                                // SizedBox(
                                //     child: Text(
                                //   '$errorinnumbreplate',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .caption!
                                //       .copyWith(color: Colors.red),
                                // )),
                                Visibility(
                                  visible: _isvisible1,
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: CustomDropdownwidget(
                                              validator: (val) =>
                                                  val?.isEmpty == true ||
                                                          val == null
                                                      ? 'Required!'
                                                      : null,
                                              droplabel: 'Zonal Code',
                                              list: const [
                                                'ME',
                                                'KO',
                                                'SA',
                                                'JA',
                                                'BA',
                                                'NA',
                                                'GA',
                                                'LU',
                                                'DH',
                                                'RA',
                                                'BHE',
                                                'KA',
                                                'SE',
                                                'MA',
                                              ],
                                              onSaved: (String? value) {
                                                store.zonal_code = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  store.zonal_code = value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: TextFormField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    3),
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onSaved: (String? value) {
                                                store.lot_number = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  store.lot_number = value;
                                                });
                                              },
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(fontSize: 18.0),
                                              validator: (val) => val!.isEmpty
                                                  ? 'Required!'
                                                  : null,
                                              decoration: InputDecoration(
                                                labelText: 'Lot Number',
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: CustomDropdownwidget(
                                              validator: (val) =>
                                                  val?.isEmpty == true ||
                                                          val == null
                                                      ? 'Required!'
                                                      : null,
                                              droplabel: 'Vehicle Type',
                                              list: const [
                                                'KA',
                                                'KHA',
                                                'GA',
                                                'C.D.',
                                                'YA',
                                                'GHA',
                                                'CA',
                                                'JA',
                                                'JHA',
                                                'ÑA',
                                                'PA',
                                                'PHA',
                                                'BA',
                                              ],
                                              onSaved: (String? value) {
                                                store.v_type = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  store.v_type = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        child: TextFormField(
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(4),
                                          ],
                                          keyboardType: TextInputType.number,
                                          onSaved: (String? value) {
                                            store.v_no = value;
                                          },
                                          onChanged: (String? value) {
                                            setState(() {
                                              store.v_no = value;
                                            });
                                          },
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(fontSize: 18.0),
                                          validator: (val) =>
                                              val!.isEmpty ? 'Required!' : null,
                                          decoration: InputDecoration(
                                            labelText: 'Vehicle Number',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .caption,
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors
                                                      .grey), //<-- SEE HERE
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(8.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  width: 1, color: Colors.grey),
                                            ),
                                          ),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            '${store.zonal_code ?? ''}-${store.lot_number ?? ''}-${store.v_type ?? ''}-${store.v_no ?? ''}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          )),
                                      SizedBox(
                                        height: 15.0,
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: _isvisible2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          // SizedBox(
                                          //   width: 100.0,
                                          //   child: CustomDropdownwidget(
                                          //     validator: (val) =>
                                          //         val?.isEmpty == true ||
                                          //                 val == null
                                          //             ? 'Required!'
                                          //             : null,
                                          //     droplabel: 'Province',
                                          //     list: const [
                                          //       'Province No.1',
                                          //       'Madhesh',
                                          //       'Bagmati',
                                          //       'Gandaki',
                                          //       'Lumbini',
                                          //       'Karnali',
                                          //       'Sudurpashchim'
                                          //     ],

                                          //   ),
                                          // ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: CustomDropdownwidget(
                                              validator: (val) =>
                                                  val?.isEmpty == true ||
                                                          val == null
                                                      ? 'Required!'
                                                      : null,
                                              droplabel: 'Province',
                                              list: prov,
                                              onSaved: (String? value) {
                                                store.province = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  store.province = value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: CustomDropdownwidget(
                                              validator: (val) =>
                                                  val?.isEmpty == true ||
                                                          val == null
                                                      ? 'Required!'
                                                      : null,
                                              droplabel: 'Office Code',
                                              list: const [
                                                '1',
                                                '2',
                                                '3',
                                                '4',
                                                '5',
                                                '6',
                                                '7'
                                              ],
                                              onSaved: (String? value) {
                                                store.office_code = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  store.office_code = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextFormField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    3),
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onSaved: (String? value) {
                                                store.lot_number = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  store.lot_number = value;
                                                });
                                              },
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(fontSize: 18.0),
                                              validator: (val) => val!.isEmpty
                                                  ? 'Required!'
                                                  : null,
                                              decoration: InputDecoration(
                                                labelText: 'Lot Number',
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 53.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: CustomDropdownwidget(
                                              validator: (val) =>
                                                  val?.isEmpty == true ||
                                                          val == null
                                                      ? 'Required!'
                                                      : null,
                                              droplabel: 'Symbol',
                                              list: const [
                                                'A',
                                                'B',
                                                'C',
                                                'C1',
                                                'D',
                                                'E',
                                                'F',
                                                'G',
                                                'H',
                                                'H1',
                                                'H2',
                                                'I',
                                                'I1',
                                                'I2',
                                                'I3',
                                                'J1',
                                                'J2',
                                                'J3',
                                                'J4',
                                                'J5',
                                                'K'
                                              ],
                                              onSaved: (String? value) {
                                                store.symbol = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  store.symbol = value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: TextFormField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    4),
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onSaved: (String? value) {
                                                store.v_no = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  store.v_no = value;
                                                });
                                              },
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(fontSize: 18.0),
                                              validator: (val) => val!.isEmpty
                                                  ? 'Required!'
                                                  : null,
                                              decoration: InputDecoration(
                                                labelText: 'Vehicle Number',
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(8.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  width: 1, color: Colors.grey),
                                            ),
                                          ),
                                          child: Text(
                                            '${store.province ?? ''}-${store.office_code ?? ''}-${store.lot_number ?? ''}-${store.symbol ?? ''}-${store.v_no ?? ''}',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          )),
                                      SizedBox(
                                        height: 15.0,
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  'Major Accident*',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                CustomRadioFormField(
                                  fieldname1: 'Yes',
                                  fieldname2: 'No',
                                  formkey: formkey1,
                                  grpvalue: val1,
                                  ctx: context,
                                  onChanged: (newValue) {
                                    setState(() {
                                      val1 = newValue;
                                      store.major_accident =
                                          val1 == 1 ? 'Yes' : 'No';
                                      store.major_accident_radio = val1;
                                    });
                                  },
                                  onSaved: (Finalvalue) {
                                    print('value: $val1');
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                // Row(
                                //   children: <Widget>[
                                //     Radio<int>(
                                //         value: 1,
                                //         groupValue: val1,
                                //         activeColor: Theme.of(context)
                                //             .colorScheme
                                //             .secondary,
                                //         onChanged: (int? value) {
                                //           setState(() {
                                //             val1 = value;
                                //             store.major_accident = 'Yes';
                                //             store.major_accident_radio = 1;
                                //           });
                                //         }),
                                //     Text("Yes",
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .caption),
                                //     const SizedBox(
                                //       width: 88.0,
                                //     ),
                                //     Radio<int>(
                                //         value: 2,
                                //         groupValue: val1,
                                //         activeColor: Theme.of(context)
                                //             .colorScheme
                                //             .secondary,
                                //         onChanged: (int? value) {
                                //           setState(() {
                                //             val1 = value;
                                //             store.major_accident = 'no';
                                //             store.major_accident_radio = 2;
                                //           });
                                //         }),
                                //     Text("No",
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .caption),
                                //   ],
                                // ),
                                // SizedBox(
                                //     child: Text(
                                //   '$errorinaccident',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .caption!
                                //       .copyWith(color: Colors.red),
                                // )),
                                Text(
                                  'Service History*',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                CustomRadioFormField(
                                  fieldname1: 'Yes',
                                  fieldname2: 'No',
                                  formkey: formkey1,
                                  grpvalue: val2,
                                  ctx: context,
                                  onChanged: (newValue) {
                                    setState(() {
                                      val2 = newValue;

                                      store.service_history =
                                          val2 == 1 ? 'Yes' : 'No';
                                      store.service_history_radio = val2;
                                    });
                                  },
                                  onSaved: (Finalvalue) {
                                    print('value: $val2');
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                // Row(
                                //   children: <Widget>[
                                //     Radio<int>(
                                //         value: 1,
                                //         groupValue: val2,
                                //         activeColor: Theme.of(context)
                                //             .colorScheme
                                //             .secondary,
                                //         onChanged: (int? value) {
                                //           setState(() {
                                //             val2 = value;
                                //             store.service_history = 'Yes';
                                //             store.service_history_radio = 1;
                                //           });
                                //         }),
                                //     Text("Yes",
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .caption),
                                //     const SizedBox(width: 88.0),
                                //     Radio<int>(
                                //         value: 2,
                                //         groupValue: val2,
                                //         activeColor: Theme.of(context)
                                //             .colorScheme
                                //             .secondary,
                                //         onChanged: (int? value) {
                                //           setState(() {
                                //             val2 = value;
                                //             store.service_history = 'no';
                                //             store.service_history_radio = 2;
                                //           });
                                //         }),
                                //     Text("No",
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .caption),
                                //   ],
                                // ),
                                // SizedBox(
                                //     child: Text(
                                //   '$errorinhistory',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .caption!
                                //       .copyWith(color: Colors.red),
                                // )),
                                FutureBuilder(
                                    future: future1,
                                    builder: (BuildContext ctx,
                                        AsyncSnapshot<B_V_fromAPI?> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Column(
                                          children: [
                                            CustomDropdownwidget(
                                                droplabel: 'Brand Name*',
                                                validator: (val) => val!.isEmpty
                                                    ? 'Required!'
                                                    : null,
                                                onChanged: null,
                                                dropdownvalue:
                                                    "Please Wait......",
                                                list: []),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                          ],
                                        );
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Text(snapshot.error
                                                      .toString())),
                                              OutlinedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      future1 = getb();
                                                    });
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.white),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .zero,
                                                              side: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary)))),
                                                  child: const Text('Retry'))
                                            ],
                                          );
                                        } else if (snapshot.hasData) {
                                          futureresult1 = true;
                                          return DropdownButtonFormField(
                                            validator: (val) => val == null
                                                ? 'Select a brand name please'
                                                : null,
                                            menuMaxHeight: 250.0,
                                            decoration: InputDecoration(
                                              labelText: 'Brand Name*',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey), //<-- SEE HERE
                                              ),
                                            ),
                                            value: dropdownvalue1,
                                            items: snapshot.data!.brandlist!
                                                .map((e) {
                                              return DropdownMenuItem(
                                                  alignment: Alignment.center,
                                                  value: e.id,
                                                  child: Text(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                              fontSize: 18.0),
                                                      textAlign:
                                                          TextAlign.start,
                                                      e.name ?? ''));
                                            }).toList(),
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey,
                                            ),
                                            onChanged: (int? newValue) {
                                              setState(() {
                                                dropdownvalue1 = newValue!;
                                                store.brand_id =
                                                    newValue.toString();
                                                dropdownvalue2 = null;
                                                dropdownvalue3 = null;
                                                future2 = getve(
                                                    store.brand_id.toString());
                                              });
                                            },
                                            onSaved: (int? value) {
                                              //store.brand_id = brands.indexOf(value!).toString();
                                              setState(() {
                                                store.brand_id =
                                                    value.toString();
                                              });
                                            },
                                          );
                                        }
                                      }
                                      return const Text('No future');
                                    }),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                FutureBuilder(
                                    future: future2,
                                    builder: (BuildContext ctx,
                                        AsyncSnapshot<B_V_fromAPI?> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CustomDropdownwidget(
                                            validator: (val) => val!.isEmpty
                                                ? 'Required!'
                                                : null,
                                            onChanged: null,
                                            droplabel: 'Model Name*',
                                            dropdownvalue: "Please wait..",
                                            list: []);
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Text(snapshot.error
                                                      .toString())),
                                              OutlinedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      future2 = getve(
                                                          store.brand_id ??
                                                              '1');
                                                    });
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.white),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .zero,
                                                              side: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary)))),
                                                  child: const Text('Retry'))
                                            ],
                                          );
                                        } else if (snapshot.hasData) {
                                          futureresult2 = true;
                                          return DropdownButtonFormField(
                                            validator: (val) => val == null
                                                ? 'Select a model name please'
                                                : null,
                                            menuMaxHeight: 250.0,
                                            decoration: InputDecoration(
                                              labelText: 'Model Name*',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            value: dropdownvalue2,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey,
                                            ),
                                            items: snapshot.data!.vehiclelist!
                                                .map((e) {
                                              return DropdownMenuItem(
                                                  alignment: Alignment.center,
                                                  value: e.id,
                                                  child: Text(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                              fontSize: 18.0),
                                                      textAlign:
                                                          TextAlign.start,
                                                      e.vehicleName ?? ''));
                                            }).toList(),
                                            onChanged: (int? newValue) {
                                              setState(() {
                                                dropdownvalue2 = newValue!;
                                                store.vehicle_name_id =
                                                    newValue.toString();
                                                dropdownvalue3 = null;
                                                future3 = getva(store
                                                    .vehicle_name_id!
                                                    .toString());
                                              });
                                            },
                                            onSaved: (int? value) {
                                              store.vehicle_name_id =
                                                  value.toString();
                                              // store.vehicle_value =value;
                                            },
                                          );
                                        }
                                      }
                                      return const Text('No future');
                                    }),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                FutureBuilder(
                                    future: future3,
                                    builder: (BuildContext ctx,
                                        AsyncSnapshot<B_V_fromAPI?> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CustomDropdownwidget(
                                            validator: (val) => val!.isEmpty
                                                ? 'Required!'
                                                : null,
                                            onChanged: null,
                                            droplabel: 'Variant Name*',
                                            dropdownvalue: "Please Wait......",
                                            list: []);
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Text(snapshot.error
                                                      .toString())),
                                              OutlinedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      future3 = getva(store
                                                              .vehicle_name_id ??
                                                          '1');
                                                    });
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.white),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .zero,
                                                              side: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary)))),
                                                  child: const Text('Retry'))
                                            ],
                                          );
                                        } else if (snapshot.hasData) {
                                          futureresult3 = true;
                                          return DropdownButtonFormField(
                                            validator: (val) => val == null
                                                ? 'Select a variant name please'
                                                : null,
                                            menuMaxHeight: 250.0,
                                            decoration: InputDecoration(
                                              labelText: 'Variant Name*',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            value: dropdownvalue3,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey,
                                            ),
                                            items: snapshot.data!.variantlist!
                                                .map((e) {
                                              return DropdownMenuItem(
                                                alignment: Alignment.center,
                                                value: e.id,
                                                child: Text(
                                                  e.variantName!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(fontSize: 18.0),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (int? newValue) {
                                              dropdownvalue3 = newValue!;
                                            },
                                            onSaved: (int? value) {
                                              store.variant_id =
                                                  value.toString();
                                            },
                                          );
                                        }
                                      }
                                      return const Text('No future');
                                    }),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  onSaved: (String? value) {
                                    store.engine_no = value;
                                  },
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(fontSize: 18.0),
                                  validator: (val) => val!.isEmpty
                                      ? 'Enter the engine number please.'
                                      : null,
                                  decoration: InputDecoration(
                                    labelText: 'Engine Number*',
                                    labelStyle:
                                        Theme.of(context).textTheme.caption,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey), //<-- SEE HERE
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          DropdownButtonFormField(
                            menuMaxHeight: 250.0,
                            decoration: InputDecoration(
                              labelText: 'Manufacture Year (optional)',
                              labelStyle: Theme.of(context).textTheme.caption,
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey), //<-- SEE HERE
                              ),
                            ),
                            value: dropdownvalue4,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                            ),
                            items: years.map((String val) {
                              return DropdownMenuItem(
                                alignment: Alignment.center,
                                value: val,
                                child: Text(
                                  val,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontSize: 18.0),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              dropdownvalue4 = newValue;
                              store.manufacture_year = newValue;
                            },
                          ),
                          Form(
                              key: formkey2,
                              autovalidateMode: _autoValidate,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    onSaved: (String? value) {
                                      store.color = value;
                                    },
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontSize: 18.0),
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter the color please.'
                                        : null,
                                    decoration: InputDecoration(
                                      labelText: 'Color*',
                                      labelStyle:
                                          Theme.of(context).textTheme.caption,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onSaved: (String? value) {
                                      store.no_of_seats = value;
                                    },
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontSize: 18.0),
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter the no. of seat please.'
                                        : null,
                                    decoration: InputDecoration(
                                      labelText: 'No. of Seat*',
                                      labelStyle:
                                          Theme.of(context).textTheme.caption,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  DropdownButtonFormField(
                                    validator: (val) => val == null
                                        ? 'Select a year please'
                                        : null,
                                    menuMaxHeight: 250.0,
                                    decoration: InputDecoration(
                                      labelText: 'Purchase Year*',
                                      labelStyle:
                                          Theme.of(context).textTheme.caption,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    value: dropdownvalue5,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.grey,
                                    ),
                                    items: years.map((String val) {
                                      return DropdownMenuItem(
                                        alignment: Alignment.center,
                                        value: val,
                                        child: Text(
                                          val,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(fontSize: 18.0),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      dropdownvalue5 = newValue!;
                                    },
                                    onSaved: (String? value) {
                                      store.purchase_year = value;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: SizedBox(
                                        height: 15.0,
                                        child: Text('$errorinpurchase',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(color: Colors.red))),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onSaved: (String? value) {
                                      store.no_of_transfer = value;
                                    },
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontSize: 18.0),
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter the no. of past owners please.'
                                        : null,
                                    decoration: InputDecoration(
                                      labelText: 'No. of Past owners*',
                                      labelStyle:
                                          Theme.of(context).textTheme.caption,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onSaved: (String? value) {
                                      store.kilometer = value;
                                    },
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontSize: 18.0),
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter the mileage please.'
                                        : null,
                                    decoration: InputDecoration(
                                      labelText: 'Mileage*',
                                      labelStyle:
                                          Theme.of(context).textTheme.caption,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40.0,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () async {
                                        if (futureresult1 == true &&
                                            futureresult2 == true &&
                                            futureresult3 == true) {
                                          if (formkey1.currentState!
                                                  .validate() &&
                                              formkey2.currentState!
                                                  .validate()) {
                                            if (dropdownvalue4 == null ||
                                                int.parse(dropdownvalue4!) <=
                                                    int.parse(
                                                        dropdownvalue5!)) {
                                              errorinpurchase = '';

                                              formkey1.currentState!.save();
                                              formkey2.currentState!.save();
                                              if (kDebugMode) {
                                                print(
                                                    'Client Side Validated ${store.manufacture_year} ');
                                              }
                                              if (store.number_plate_radio ==
                                                  1) {
                                                store.vehicle_no =
                                                    '${store.zonal_code}-${store.lot_number}-${store.v_type} ${store.v_no} ';
                                              } else if (store
                                                      .number_plate_radio ==
                                                  2) {
                                                store.vehicle_no =
                                                    '${store.province}-${store.office_code}-${store.lot_number} ${store.symbol} ${store.v_no} ';
                                              }
                                              dynamic Val;
                                              dynamic searchrequestModel =
                                                  new SearchRequestModel();
                                              searchrequestModel
                                                      .vehicle_number =
                                                  store.engine_no;
                                              APIService apiService =
                                                  APIService();
                                              await apiService
                                                  .searchvehicle(
                                                      searchrequestModel)
                                                  .then((value) {
                                                dynamic Val =
                                                    value!.data!.vehicle;
                                                if (Val == null) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PersonalInfo(
                                                                  title: widget
                                                                      .title,
                                                                  store: store,
                                                                  bvinfoAPI:
                                                                      bfa)));
                                                } else {
                                                  final snackBar = SnackBar(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              226, 114, 107),
                                                      content: Text(
                                                          'The Vehicle with this Engine Number Already exists!'));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                }
                                              });
                                            } else {
                                              setState(() {
                                                errorinpurchase =
                                                    'Purchase Year cannot be before Manufacture Year';
                                              });
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: 'Please fill out the form properly',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.5),
                                                textColor: Colors.black);
                                            setState(() => _autoValidate =
                                                AutovalidateMode.always);
                                          } //validator
                                        } else {
                                          final snackBar = SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 226, 114, 107),
                                              content: Text('Reload please'));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  side: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary)))),
                                      child: Text('Next',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 34.0,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ],
                              ))
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
