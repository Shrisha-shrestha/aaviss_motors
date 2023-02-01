import 'package:aaviss_motors/screens/legal_info.dart';
import 'package:aaviss_motors/screens/personnel_info.dart';
import 'package:aaviss_motors/screens/search_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../API/API_connection.dart';
import '../models/searchvehicle.dart';
import '../models/storevehicleinfo.dart';
import '../widgets/dropdown.dart';

class VehicleInfo extends StatefulWidget {
  const VehicleInfo({super.key, required this.title, required this.store});
  final String title;
  final Store store;
  @override
  State<VehicleInfo> createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
  int? val1, val2, val3, val4;
  dynamic val;
  List<String> years = [], test = [''];
  int? dropdownvalue1, dropdownvalue2, dropdownvalue3;
  String? dropdownvalue, dropdownvalue4, dropdownvalue5;
  String? d1, d2, d3, d4;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _isvisible1 = false, _isvisible2 = false;
  String? errorinaccident = '',
      errorinhistory = '',
      errorinpurchase = '',
      errorinvehicletype = '',
      errorinnumbreplate = '';
  Future<B_V_fromAPI>? future;
  B_V_fromAPI bfa = B_V_fromAPI();
  bool futureresult = false;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  Future<B_V_fromAPI>? getbvv() async {
    dynamic brandlist, vehiclelist, variantlist;
    APIService apiService = APIService();
    int? len1, len2, len3;
    List<String>? brands = [], vehicles = [], variants = [];
    List<int>? brandsId = [], vehiclesId = [], variantId = [];
    await apiService.getbrand().then((value) {
      brandlist = value!.outerdata!.brands!.innerdata!;
      len1 = value.outerdata!.brands!.total;
    });
    await apiService.getvehicle().then((value) {
      vehiclelist = value.data!.vehicleNames!.data!;
      len2 = value.data!.vehicleNames!.total;
    });
    await apiService.getvariant().then((value) {
      variantlist = value.data!.variants!.data!;
      len3 = value.data!.variants!.total;
    });

    for (int i = 0; i < len1!; i++) {
      brands.add("${brandlist[i].name}");
      brandsId.add(brandlist[i].id);
    }
    for (int i = 0; i < len2!; i++) {
      vehicles.add("${vehiclelist[i].vehicleName}");
      vehiclesId.add(vehiclelist[i].id);
    }
    for (int i = 0; i < len3!; i++) {
      variants.add("${variantlist[i].variantName}");
      variantId.add(variantlist[i].id);
    }

    final theMap1 = Map.fromIterables(brandsId, brands);
    final theMap2 = Map.fromIterables(vehiclesId, vehicles);
    final theMap3 = Map.fromIterables(variantId, variants);
    bfa.brandlist = brandlist;
    bfa.vehiclelist = vehiclelist;
    bfa.variantlist = variantlist;
    bfa.blist = theMap1;
    bfa.velist = theMap2;
    bfa.valist = theMap3;
    return bfa;
  }

  @override
  void initState() {
    int now = DateTime.now().year;
    for (now; now >= 1960; now--) {
      years.add(now.toString());
    }
    future = getbvv();
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
          title: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(widget.title,
                  style: Theme.of(context).textTheme.headline5)),
          // leading: Transform.translate(offset: Offset(-15, 0),),
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
                                      '2',
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
                                const EdgeInsets.only(top: 30.0, bottom: 10.0),
                            child: Text(
                              'Vehicle Information',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          Form(
                            key: formkey,
                            autovalidateMode: _autoValidate,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FutureBuilder(
                                    future: future,
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
                                            CustomDropdownwidget(
                                                validator: (val) => val!.isEmpty
                                                    ? 'Required!'
                                                    : null,
                                                onChanged: null,
                                                droplabel: 'Vehicle Name*',
                                                dropdownvalue:
                                                    "Please Wait......",
                                                list: []),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            CustomDropdownwidget(
                                                validator: (val) => val!.isEmpty
                                                    ? 'Required!'
                                                    : null,
                                                onChanged: null,
                                                droplabel: 'Variant Name*',
                                                dropdownvalue:
                                                    "Please Wait......",
                                                list: []),
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
                                                      future = getbvv();
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
                                          futureresult = true;
                                          return Column(
                                            children: [
                                              DropdownButtonFormField(
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
                                                      alignment:
                                                          Alignment.center,
                                                      value: e.id,
                                                      child: Text(
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          18.0),
                                                          textAlign:
                                                              TextAlign.start,
                                                          e.name ?? ''));
                                                }).toList(),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.grey,
                                                ),
                                                onChanged: (int? newValue) {
                                                  dropdownvalue1 = newValue!;
                                                },
                                                onSaved: (int? value) {
                                                  //widget.store.brand_id = brands.indexOf(value!).toString();
                                                  widget.store.brand_id =
                                                      value.toString();
                                                },
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              DropdownButtonFormField(
                                                validator: (val) => val == null
                                                    ? 'Select a vehicle name please'
                                                    : null,
                                                menuMaxHeight: 250.0,
                                                decoration: InputDecoration(
                                                  labelText: 'Vehicle Name*',
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
                                                items: snapshot
                                                    .data!.vehiclelist!
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                      alignment:
                                                          Alignment.center,
                                                      value: e.id,
                                                      child: Text(
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          18.0),
                                                          textAlign:
                                                              TextAlign.start,
                                                          e.vehicleName ?? ''));
                                                }).toList(),
                                                onChanged: (int? newValue) {
                                                  dropdownvalue2 = newValue!;
                                                },
                                                onSaved: (int? value) {
                                                  widget.store.vehicle_name_id =
                                                      value.toString();
                                                  // widget.store.vehicle_value =value;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              DropdownButtonFormField(
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
                                                items: snapshot
                                                    .data!.variantlist!
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                    alignment: Alignment.center,
                                                    value: e.id,
                                                    child: Text(
                                                      e.variantName!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2!
                                                          .copyWith(
                                                              fontSize: 18.0),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (int? newValue) {
                                                  dropdownvalue3 = newValue!;
                                                },
                                                onSaved: (int? value) {
                                                  widget.store.variant_id =
                                                      value.toString();
                                                },
                                              ),
                                            ],
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
                                    widget.store.engine_no = value;
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
                                const SizedBox(
                                  height: 10.0,
                                ),
                                DropdownButtonFormField(
                                  validator: (val) => val == null
                                      ? 'Select a year please'
                                      : null,
                                  menuMaxHeight: 250.0,
                                  decoration: InputDecoration(
                                    labelText: 'Manufacture Year*',
                                    labelStyle:
                                        Theme.of(context).textTheme.caption,
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
                                    dropdownvalue4 = newValue!;
                                  },
                                  onSaved: (String? value) {
                                    widget.store.manufacture_year = value;
                                  },
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  onSaved: (String? value) {
                                    widget.store.color = value;
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
                                    widget.store.no_of_seats = value;
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
                                    widget.store.purchase_year = value;
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
                                    widget.store.no_of_transfer = value;
                                  },
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(fontSize: 18.0),
                                  validator: (val) => val!.isEmpty
                                      ? 'Enter the no. of transfers please.'
                                      : null,
                                  decoration: InputDecoration(
                                    labelText: 'No. of Transfers*',
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
                                    widget.store.kilometer = value;
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
                                  height: 35.0,
                                ),
                                Text(
                                  'Major Accident*',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio<int>(
                                        value: 1,
                                        groupValue: val1,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        onChanged: (int? value) {
                                          setState(() {
                                            val1 = value;
                                            widget.store.major_accident = 'Yes';
                                            widget.store.major_accident_radio =
                                                1;
                                          });
                                        }),
                                    Text("Yes",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                    const SizedBox(
                                      width: 88.0,
                                    ),
                                    Radio<int>(
                                        value: 2,
                                        groupValue: val1,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        onChanged: (int? value) {
                                          setState(() {
                                            val1 = value;
                                            widget.store.major_accident = 'no';
                                            widget.store.major_accident_radio =
                                                2;
                                          });
                                        }),
                                    Text("No",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                  ],
                                ),
                                SizedBox(
                                    child: Text(
                                  '$errorinaccident',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.red),
                                )),
                                Text(
                                  'Service History*',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio<int>(
                                        value: 1,
                                        groupValue: val2,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        onChanged: (int? value) {
                                          setState(() {
                                            val2 = value;
                                            widget.store.service_history =
                                                'Yes';
                                            widget.store.service_history_radio =
                                                1;
                                          });
                                        }),
                                    Text("Yes",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                    const SizedBox(width: 88.0),
                                    Radio<int>(
                                        value: 2,
                                        groupValue: val2,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        onChanged: (int? value) {
                                          setState(() {
                                            val2 = value;
                                            widget.store.service_history = 'no';
                                            widget.store.service_history_radio =
                                                2;
                                          });
                                        }),
                                    Text("No",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                  ],
                                ),
                                SizedBox(
                                    child: Text(
                                  '$errorinhistory',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.red),
                                )),
                                Text(
                                  'Vehicle Type*',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio<int>(
                                        value: 1,
                                        groupValue: val3,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        onChanged: (int? value) {
                                          setState(() {
                                            val3 = value;
                                            widget.store.vehicle_type =
                                                'private';
                                            widget.store.vehicle_type_radio = 1;
                                          });
                                        }),
                                    Text("Private",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                    const SizedBox(
                                      width: 72.0,
                                    ),
                                    Radio<int>(
                                        value: 2,
                                        groupValue: val3,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        onChanged: (int? value) {
                                          setState(() {
                                            val3 = value;
                                            widget.store.vehicle_type =
                                                'public';
                                            widget.store.vehicle_type_radio = 2;
                                          });
                                        }),
                                    Text("Public",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                  ],
                                ),
                                SizedBox(
                                    child: Text(
                                  '$errorinvehicletype',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.red),
                                )),
                                Text(
                                  'Number Plate*',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio<int>(
                                        value: 1,
                                        groupValue: val4,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        onChanged: (int? value) {
                                          setState(() {
                                            val4 = value;
                                            _isvisible2 = false;
                                            _isvisible1 = true;
                                            widget.store.number_plate_radio = 1;
                                          });
                                        }),
                                    Text("Zonal",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                    const SizedBox(
                                      width: 78.0,
                                    ),
                                    Radio<int>(
                                        value: 2,
                                        groupValue: val4,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        onChanged: (int? value) {
                                          setState(() {
                                            val4 = value;
                                            _isvisible2 = true;
                                            _isvisible1 = false;
                                            widget.store.number_plate_radio = 2;
                                          });
                                        }),
                                    Text("Provincal",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                  ],
                                ),
                                SizedBox(
                                    child: Text(
                                  '$errorinnumbreplate',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.red),
                                )),
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
                                            width: 91.0,
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
                                                widget.store.zonal_code = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  widget.store.zonal_code =
                                                      value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 91.0,
                                            child: TextFormField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    3),
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onSaved: (String? value) {
                                                widget.store.lot_number = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  widget.store.lot_number =
                                                      value;
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
                                            width: 91.0,
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
                                                widget.store.v_type = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  widget.store.v_type = value;
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
                                        width: 91.0,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          onSaved: (String? value) {
                                            widget.store.v_no = value;
                                          },
                                          onChanged: (String? value) {
                                            setState(() {
                                              widget.store.v_no = value;
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
                                        height: 30.0,
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
                                            '${widget.store.zonal_code ?? ''}-${widget.store.lot_number ?? ''}-${widget.store.v_type ?? ''}-${widget.store.v_no ?? ''}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          )),
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
                                          SizedBox(
                                            width: 91.0,
                                            child: CustomDropdownwidget(
                                              validator: (val) =>
                                                  val?.isEmpty == true ||
                                                          val == null
                                                      ? 'Required!'
                                                      : null,
                                              droplabel: 'Province',
                                              list: const [
                                                'Province No. 1',
                                                'Madhesh province',
                                                'Bagmati province',
                                                'Gandaki province',
                                                'Lumbini province',
                                                'Karnali province',
                                                'Sudurpashchim province'
                                              ],
                                              onSaved: (String? value) {
                                                widget.store.province = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  widget.store.province = value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 91.0,
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
                                                widget.store.office_code =
                                                    value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  widget.store.office_code =
                                                      value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 91.0,
                                            child: TextFormField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    3),
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              onSaved: (String? value) {
                                                widget.store.lot_number = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  widget.store.lot_number =
                                                      value;
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
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 91.0,
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
                                                widget.store.symbol = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  widget.store.symbol = value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                          ),
                                          SizedBox(
                                            width: 91.0,
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              onSaved: (String? value) {
                                                widget.store.v_no = value;
                                              },
                                              onChanged: (String? value) {
                                                setState(() {
                                                  widget.store.v_no = value;
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
                                        height: 30.0,
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
                                            '${widget.store.province ?? ''}-${widget.store.office_code ?? ''}-${widget.store.lot_number ?? ''}-${widget.store.symbol ?? ''}-${widget.store.v_no ?? ''}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 46.0,
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
                                                    borderRadius:
                                                        BorderRadius.zero,
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
                                      onPressed: () async {
                                        if (futureresult) {
                                          if (formkey.currentState!
                                              .validate()) {
                                            if (val1 != null) {
                                              setState(() {
                                                errorinaccident = '';
                                              });
                                              if (val2 != null) {
                                                setState(() {
                                                  errorinhistory = '';
                                                });
                                                if (val3 != null) {
                                                  setState(() {
                                                    errorinvehicletype = '';
                                                  });
                                                  if (val4 != null) {
                                                    setState(() {
                                                      errorinnumbreplate = '';
                                                    });
                                                    if (int.parse(
                                                            dropdownvalue4!) <=
                                                        int.parse(
                                                            dropdownvalue5!)) {
                                                      errorinpurchase = '';
                                                      formkey.currentState!
                                                          .save();
                                                      if (kDebugMode) {
                                                        print(
                                                            'Client Side Validated');
                                                      }
                                                      if (widget.store
                                                              .number_plate_radio ==
                                                          1) {
                                                        widget.store
                                                                .vehicle_no =
                                                            '${widget.store.zonal_code}-${widget.store.lot_number}-${widget.store.v_type} ${widget.store.v_no} ';
                                                      } else if (widget.store
                                                              .number_plate_radio ==
                                                          2) {
                                                        widget.store
                                                                .vehicle_no =
                                                            '${widget.store.province}-${widget.store.office_code}-${widget.store.lot_number} ${widget.store.symbol} ${widget.store.v_no} ';
                                                      }
                                                      dynamic Val;
                                                      dynamic
                                                          searchrequestModel =
                                                          new SearchRequestModel();
                                                      searchrequestModel
                                                              .vehicle_number =
                                                          widget
                                                              .store.engine_no;
                                                      APIService apiService =
                                                          APIService();
                                                      await apiService
                                                          .searchvehicle(
                                                              searchrequestModel)
                                                          .then((value) {
                                                        dynamic Val = value!
                                                            .data!.vehicle;
                                                        if (Val == null) {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (context) => LegalInfo(
                                                                      title: widget
                                                                          .title,
                                                                      store: widget
                                                                          .store,
                                                                      bvinfoAPI:
                                                                          bfa)));
                                                        } else {
                                                          final snackBar = SnackBar(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          226,
                                                                          114,
                                                                          107),
                                                              content: Text(
                                                                  'The Vehicle with this Engine Number Already exists!'));
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        }
                                                      });
                                                    } else {
                                                      setState(() {
                                                        errorinpurchase =
                                                            'Purchase Year cannot be before Manufacture Year';
                                                      });
                                                    }
                                                  } else {
                                                    setState(() {
                                                      errorinnumbreplate =
                                                          'Please Select One';
                                                    });
                                                  }
                                                } else {
                                                  setState(() {
                                                    errorinvehicletype =
                                                        'Please Select One';
                                                  });
                                                }
                                              } else {
                                                setState(() {
                                                  errorinhistory =
                                                      'Please select one';
                                                });
                                              }
                                            } else {
                                              print(2);
                                              setState(() {
                                                errorinaccident =
                                                    'Please select one';
                                              });
                                            }
                                          } else {
                                            setState(() => _autoValidate =
                                                AutovalidateMode.always);
                                          }
                                        }
                                        ;
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 34.0,
                            width: MediaQuery.of(context).size.width,
                          ),
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
