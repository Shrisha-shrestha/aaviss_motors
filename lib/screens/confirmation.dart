import 'dart:convert';
import 'dart:io';
import 'package:aaviss_motors/models/getbrand.dart';
import 'package:aaviss_motors/models/getvehiclename.dart';
import 'package:aaviss_motors/screens/search_detail.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import'package:aaviss_motors/models/storevehicleinfo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../models/confirmation_response.dart';
import 'finish_screen.dart';
import 'package:flutter/foundation.dart';
class Confirmation extends StatefulWidget {
  const Confirmation({super.key, required this.title,required this.store,required this.bvinfoAPI});
  final String title;
  final Store store;
  final B_V_fromAPI bvinfoAPI;
  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  int? brandid;
  List<String> years=[];
  List<Innerdata> brands=[];
  List<innerdata> vehicles=[];
  List<List<String>> vehicle= [['v1','v2'],['v3','v4']];
  String? dropdownvalue3,dropdownvalue4;
  bool _isvisible1 = false,_isvisible2 =false;
  bool _isvisible3 = false,_isvisible4 =false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Store store = Store();
  // File?  image1,image2,image3,image4,image5;
  final _picker = ImagePicker();
  Future<File?> getImage()async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery , imageQuality: 20);
    if(pickedFile!= null ){
      return  File(pickedFile.path);
    }else {
      if (kDebugMode) {
        print('no image selected');
      }
      return null;
    }
  }
  // List<String>  brandbasedvehicle(int brandId){
  //   return vehicle[brandId];
  //     }
@override
  void initState(){
    int now = DateTime.now().year;
    for(now;now>=1960;now--){
      years.add(now.toString());
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // vehicles = brandbasedvehicle(int.parse(widget.store.brand_id!));
    brands=widget.bvinfoAPI.brandlist!;
    vehicles=widget.bvinfoAPI.vehiclelist!;

    if(widget.store.number_plate_radio == 1){_isvisible1 = true;}
    else if(widget.store.number_plate_radio == 2){_isvisible2 = true;}

    if(widget.store.card_type_radio == 1){
      _isvisible3 = true;
      widget.store.nid_no = widget.store.citizenship_no ;
    }
    else if(widget.store.card_type_radio == 2){
      _isvisible4 = true;
      widget.store.nid_no = widget.store.pan_no ;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: Theme.of(context).textTheme.headline5),
        titleSpacing: -30,
        toolbarHeight: 108.0,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: IconButton(icon: SvgPicture.asset(
                'assets/search.svg',
                semanticsLabel: 'Search'
            ),
                onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
          SearchDetail(title: widget.title)));},

            ),
          ),
      ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left:27.0,right: 29.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Resale Value Calculator ',
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text('Confirmation',
                  style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0,bottom:23.0),
                child: Text('Confirm All the data before submitting',
                  style: Theme.of(context).textTheme.subtitle2!,
                ),
              ),
              Expanded(
                child: Form(
                    key: _formkey,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  <Widget>[
                            Text('Personnel Data',
                              style:Theme.of(context).textTheme.bodyText2 ,),
                            TextFormField(
                              onChanged: (String? value) {
                                widget.store.full_name = value;
                              },
                              onSaved: (String? value) {
                                widget.store.full_name = value;
                              },
                              initialValue: widget.store.full_name ,
                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                              validator:(val)=> val!.isEmpty ? 'Enter your full name please.': null,
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: Theme.of(context).textTheme.caption,
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                ),
                              ),
                            ),
                            const SizedBox(height: 15.0,),
                            TextFormField(
                              onChanged: (String? value) {
                                widget.store.address = value;
                              },
                              onSaved: (String? value) {
                                widget.store.address = value;
                              },
                              initialValue: widget.store.address,
                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                              validator:(val)=> val!.isEmpty ? 'Enter your address please.': null,
                              decoration: InputDecoration(
                                  labelText: 'Address',
                                  labelStyle: Theme.of(context).textTheme.caption,
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  )
                              ),
                            ),
                            const SizedBox(height: 15.0,),
                            TextFormField(
                              onChanged: (String? value) {
                                widget.store.phone_no = value;
                              },
                              onSaved: (String? value) {
                                widget.store.phone_no = value;
                              },
                              initialValue: widget.store.phone_no,
                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                              validator:(val){
                                if(val!.isEmpty) {
                                  val = 'Enter your contact number please.';
                                }
                                else if(val.length<10 || val.length>10){
                                  val = 'Enter a correct contact number please.';
                                }
                                else
                                {val = null;}
                                return val;
                              },
                              decoration: InputDecoration(
                                labelText: 'Contact Number',
                                labelStyle: Theme.of(context).textTheme.caption,
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0),
                              child: Text('Vehicle Information',
                                style:Theme.of(context).textTheme.bodyText2 ,),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  <Widget>[
                                DropdownButtonFormField(
                                  validator:(val)=> val == null ? 'Select a brand name please': null,
                                  menuMaxHeight: 250.0,
                                  decoration: InputDecoration(
                                    labelText: 'Name of Brand',
                                    labelStyle: Theme.of(context).textTheme.caption,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                    ),
                                  ),
                                  value: int.parse(widget.store.brand_id!),
                                  icon: const Icon(Icons.arrow_drop_down,color:Colors.grey ,),
                                  items: brands.map((e) {
                                    return DropdownMenuItem(
                                        value: e.id,
                                        child: Text(
                                            style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                            textAlign: TextAlign.start,
                                            e.name ?? ''));
                                  }).toList(),
                                  onChanged: (int? newValue) {
                                    widget.store.brand_id= newValue.toString();
                                  },
                                ),
                                const SizedBox(height: 10.0,),
                                DropdownButtonFormField(
                                  validator:(val)=> val == null  ? 'Select a vehicle name please': null,
                                  menuMaxHeight: 250.0,
                                  decoration: InputDecoration(
                                    labelText: 'Name of Vehicle',
                                    labelStyle: Theme.of(context).textTheme.caption,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                    ),
                                  ),
                                  icon: const Icon(Icons.arrow_drop_down,color:Colors.grey,),
                                  value: int.parse(widget.store.vehicle_name_id!),
                                  items: vehicles.map((e) {
                                    return DropdownMenuItem(
                                        value: e.id,
                                        child: Text(
                                            style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                            textAlign: TextAlign.start,
                                            e.vehicleName ?? ''));
                                  }).toList(),
                                  onChanged: (int? newValue) {
                                      widget.store.vehicle_name_id = newValue.toString();

                                  },
                                ),
                                const SizedBox(height: 10.0,),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (String? value) {
                                    widget.store.engine_no = value;
                                  },
                                  onSaved: (String? value) {
                                    widget.store.engine_no = value;
                                  },
                                  initialValue: widget.store.engine_no,
                                  style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                  validator:(val)=> val!.isEmpty ? 'Enter the engine number please.': null,
                                  decoration: InputDecoration(
                                    labelText: 'Engine Number',
                                    labelStyle: Theme.of(context).textTheme.caption,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0,),
                                DropdownButtonFormField(
                                  validator:(val)=> val == null  ? 'Select a year please': null,
                                  menuMaxHeight: 250.0,
                                  decoration: InputDecoration(
                                    labelText: 'Manufacture Year',
                                    labelStyle: Theme.of(context).textTheme.caption,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                    ),
                                  ),
                                  value: widget.store.manufacture_year,
                                  icon: const Icon(Icons.arrow_drop_down,color:Colors.grey,),
                                  items: years.map((String val) {
                                    return DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: val,
                                      child: Text(val,style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize:18.0),),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue3 = newValue!;
                                      widget.store.manufacture_year =newValue;
                                    });
                                  },
                                ),
                                const SizedBox(height: 10.0,),
                                TextFormField(
                                  onChanged: (String? value) {
                                    widget.store.color = value;
                                  },
                                  onSaved: (String? value) {
                                    widget.store.color = value;
                                  },
                                  initialValue: widget.store.color,
                                  style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                  validator:(val)=> val!.isEmpty ? 'Enter the color please.': null,
                                  decoration: InputDecoration(
                                    labelText: 'Color',
                                    labelStyle: Theme.of(context).textTheme.caption,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0,),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (String? value) {
                                    widget.store.no_of_seats = value;
                                  },
                                  onSaved: (String? value) {
                                    widget.store.no_of_seats = value;
                                  },
                                  initialValue: widget.store.no_of_seats,
                                  style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                  validator:(val)=> val!.isEmpty ? 'Enter the no. of seat please.': null,
                                  decoration: InputDecoration(
                                    labelText: 'No. of Seat',
                                    labelStyle: Theme.of(context).textTheme.caption,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0,),
                                DropdownButtonFormField(
                                  validator:(val)=> val == null ? 'Select a year please': null,
                                  menuMaxHeight: 250.0,
                                  decoration: InputDecoration(
                                    labelText: 'Purchase Year',
                                    labelStyle: Theme.of(context).textTheme.caption,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  value: widget.store.purchase_year,
                                  icon: const Icon(Icons.arrow_drop_down,color:Colors.grey,),
                                  items: years.map((String val) {
                                    return DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: val,
                                      child: Text(val,style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize:18.0),),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue4 = newValue!;
                                      widget.store.purchase_year = newValue;
                                    });
                                  },
                                ),
                                const SizedBox(height: 10.0,),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (String? value) {
                                    widget.store.no_of_transfer = value;
                                  },
                                  onSaved: (String? value) {
                                    widget.store.no_of_transfer = value;
                                  },
                                  initialValue: widget.store.no_of_transfer,
                                  style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                  validator:(val)=> val!.isEmpty ? 'Enter the no. of transfers please.': null,
                                  decoration: InputDecoration(
                                    labelText: 'No. of Transfers',
                                    labelStyle: Theme.of(context).textTheme.caption,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15.0,),
                                Text('Vehicle Type',
                                  style: Theme.of(context).textTheme.caption,),
                                Row(
                                  children: <Widget>[
                                    Radio<int>(
                                        value: 1,
                                        groupValue: widget.store.vehicle_type_radio,
                                        toggleable: true,
                                        activeColor: Theme.of(context).colorScheme.secondary,
                                        onChanged: (int? value){
                                          setState(() {
                                            widget.store.vehicle_type_radio = value;
                                            widget.store.vehicle_type='private';
                                          });
                                        }),
                                    Text("Private",
                                        style: Theme.of(context).textTheme.caption),
                                    const SizedBox(width: 70.0,),
                                    Radio<int>(
                                        value: 2,
                                        groupValue: widget.store.vehicle_type_radio,
                                        toggleable: true,
                                        activeColor: Theme.of(context).colorScheme.secondary,
                                        onChanged: (int? value){
                                          setState(() {
                                            widget.store.vehicle_type='public';
                                            widget.store.vehicle_type_radio = value;
                                          });
                                        }),
                                    Text("Public",
                                        style: Theme.of(context).textTheme.caption),
                                  ],
                                ),
                                SizedBox(height: 20.0,
                                    child: widget.store.vehicle_type_radio == null ? Text('Please Select one.',style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.red),):const Text('')),
                                Text('Number Plate',
                                  style: Theme.of(context).textTheme.caption,),
                                Row(
                                  children: <Widget>[
                                    Radio<int>(
                                        value: 1,
                                        groupValue: widget.store.number_plate_radio,
                                        toggleable: true,
                                        activeColor: Theme.of(context).colorScheme.secondary,
                                        onChanged: (int? value){
                                          setState(() {
                                            widget.store.number_plate_radio = value;
                                            _isvisible1 =true;
                                            _isvisible2=false;
                                          });
                                        }),
                                    Text("Old",
                                        style: Theme.of(context).textTheme.caption),
                                    const SizedBox(width: 91.0,),
                                    Radio<int>(
                                        value: 2,
                                        groupValue: widget.store.number_plate_radio,
                                        toggleable: true,
                                        activeColor: Theme.of(context).colorScheme.secondary,
                                        onChanged: (int? value){
                                            setState(() {
                                              widget.store.number_plate_radio = value;
                                              _isvisible1 =false;
                                              _isvisible2=true;
                                            });

                                        }),
                                    Text("New",
                                        style: Theme.of(context).textTheme.caption),
                                  ],
                                ),
                                if(widget.store.number_plate_radio == null) ...{ Text('Please Select one.',style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.red))},
                                Visibility(
                                  visible: _isvisible1,
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 91.0,
                                            child: TextFormField(
                                              initialValue: widget.store.zonal_code,
                                              onChanged: (String? value) {
                                                widget.store.zonal_code=value;
                                              },
                                              onSaved: (String? value) {
                                                widget.store.zonal_code=value;
                                              },
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                              validator:(val)=> val!.isEmpty ? 'Required!': null,
                                              decoration: InputDecoration(
                                                labelText: 'Zonal Code',
                                                labelStyle: Theme.of(context).textTheme.caption,
                                                focusedBorder: const UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 91.0,
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              initialValue: widget.store.lot_number,
                                              onChanged: (String? value) {
                                                widget.store.lot_number=value;
                                              },
                                              onSaved: (String? value) {
                                                widget.store.lot_number=value;
                                              },
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                              validator:(val)=> val!.isEmpty ? 'Required!': null,
                                              decoration: InputDecoration(
                                                labelText: 'Lot Number',
                                                labelStyle: Theme.of(context).textTheme.caption,
                                                focusedBorder: const UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 91.0,
                                            child: TextFormField(
                                              initialValue: widget.store.v_type,
                                              onChanged: (String? value) {
                                                widget.store.v_type=value;
                                              },
                                              onSaved: (String? value) {
                                                widget.store.v_type=value;
                                              },
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                              validator:(val)=> val!.isEmpty ? 'Required!': null,
                                              decoration: InputDecoration(
                                                labelText: 'Vehicle Type',
                                                labelStyle: Theme.of(context).textTheme.caption,
                                                focusedBorder: const UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0,),
                                      SizedBox(
                                        width: 91.0,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          initialValue: widget.store.v_no,
                                          onChanged: (String? value) {
                                            widget.store.v_no=value;
                                          },
                                          onSaved: (String? value) {
                                            widget.store.v_no=value;
                                          },
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                          validator:(val)=> val!.isEmpty ? 'Required!': null,
                                          decoration: InputDecoration(
                                            labelText: 'Vehicle Number',
                                            labelStyle: Theme.of(context).textTheme.caption,
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                            ),
                                          ),
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
                                            width: 91.0,
                                            child: TextFormField(
                                              initialValue: widget.store.province,
                                              onChanged: (String? value) {
                                                widget.store.province=value;
                                              },
                                              onSaved: (String? value) {
                                                widget.store.province=value;
                                              },
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                              validator:(val)=> val!.isEmpty ? 'Required!': null,
                                              decoration: InputDecoration(
                                                labelText: 'Province',
                                                labelStyle: Theme.of(context).textTheme.caption,
                                                focusedBorder: const UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 91.0,
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              initialValue: widget.store.office_code,
                                              onChanged: (String? value) {
                                                widget.store.office_code=value;
                                              },
                                              onSaved: (String? value) {
                                                widget.store.office_code=value;
                                              },
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                              validator:(val)=> val!.isEmpty ? 'Required!': null,
                                              decoration: InputDecoration(
                                                labelText: 'Office Code',
                                                labelStyle: Theme.of(context).textTheme.caption,
                                                focusedBorder: const UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 91.0,
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              initialValue: widget.store.lot_number,
                                              onChanged: (String? value) {
                                                widget.store.lot_number=value;
                                              },
                                              onSaved: (String? value) {
                                                widget.store.lot_number=value;
                                              },
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                              validator:(val)=> val!.isEmpty ? 'Required!': null,
                                              decoration: InputDecoration(
                                                labelText: 'Lot Number',
                                                labelStyle: Theme.of(context).textTheme.caption,
                                                focusedBorder: const UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0,),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 91.0,
                                            child: TextFormField(
                                              initialValue: widget.store.symbol,
                                              onChanged: (String? value) {
                                                widget.store.symbol=value;
                                              },
                                              onSaved: (String? value) {
                                                widget.store.symbol=value;
                                              },
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                              validator:(val)=> val!.isEmpty ? 'Required!': null,
                                              decoration: InputDecoration(
                                                labelText: 'Symbol',
                                                labelStyle: Theme.of(context).textTheme.caption,
                                                focusedBorder: const UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                                          SizedBox(
                                            width: 91.0,
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              initialValue: widget.store.v_no,
                                              onChanged: (String? value) {
                                                widget.store.v_no=value;
                                              },
                                              onSaved: (String? value) {
                                                widget.store.v_no=value;
                                              },
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                              validator:(val)=> val!.isEmpty ? 'Required!': null,
                                              decoration: InputDecoration(
                                                labelText: 'Vehicle Number',
                                                labelStyle: Theme.of(context).textTheme.caption,
                                                focusedBorder: const UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Text('Citizenship / Pan',
                                style:Theme.of(context).textTheme.bodyText2 ,),
                            ),

                            Row(
                              children: <Widget>[
                                Radio(
                                    value: 1,
                                    groupValue: widget.store.card_type_radio,
                                    onChanged: (value){
                                        setState(() {
                                          widget.store.card_type_radio = value ;
                                          widget.store.nid_type = 'citizenship';
                                          _isvisible3 =true;
                                          _isvisible4=false;
                                        });

                                    }),
                                Text('Citizenship', style: Theme.of(context).textTheme.caption,),

                                const SizedBox(width: 40.0,),

                                Radio(
                                    value: 2,
                                    groupValue: widget.store.card_type_radio,
                                    onChanged: (value){
                                        setState(() {
                                          widget.store.nid_type = 'pan';
                                          widget.store.card_type_radio = value ;
                                          _isvisible3 =false;
                                          _isvisible4=true;
                                        });
                                    }),
                                Text('Pan', style: Theme.of(context).textTheme.caption,),

                              ],
                            ),
                            SizedBox(height: 20.0,
                                child: widget.store.card_type_radio == null ? Text('Please Select one.',style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.red),):const Text('')),
                            Column(
                              children:  <Widget>[
                                Visibility(
                                  visible: _isvisible3,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (String? value) {
                                      widget.store.citizenship_no=value;
                                      widget.store.nid_no=widget.store.citizenship_no;
                                    },
                                    onSaved: (String? value) {
                                      widget.store.citizenship_no=value;
                                      widget.store.nid_no=widget.store.citizenship_no;
                                    },
                                    initialValue: widget.store.citizenship_no ,
                                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                    validator: (value) => value!.isEmpty ?'Enter your Citizenship number please.': null,
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
                                  visible: _isvisible4,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (String? value) {
                                      widget.store.pan_no=value;
                                      widget.store.nid_no=widget.store.pan_no;
                                    },
                                    onSaved: (String? value) {
                                      widget.store.pan_no=value;
                                      widget.store.nid_no=widget.store.pan_no;
                                    },
                                    initialValue: widget.store.pan_no ,
                                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                    validator: (value) => value!.isEmpty ?'Enter your Pan number please.': null,
                                    decoration: InputDecoration(
                                      labelText: 'Pan Number',
                                      labelStyle: Theme.of(context).textTheme.caption,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 23.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        DottedBorder(
                                          dashPattern: const [4, 4],
                                          strokeWidth: 2,
                                          child: SizedBox(
                                            height: 130,
                                            width: MediaQuery.of(context).size.width*0.4,
                                            child:  Center(
                                              child: widget.store.img1 == null ?IconButton(
                                                onPressed:()async{
                                                  widget.store.img1  =  await getImage() ;
                                                  if(widget.store.img1 !=null){setState(() {
                                                  });}
                                                } ,
                                                icon: const Icon(Icons.upload,
                                                  color: Colors.grey,
                                                  size: 30.0,
                                                ),):
                                              Stack(
                                                children: <Widget>[
                                                  Image.file(File(widget.store.img1 !.path).absolute,
                                                    height: 130,
                                                    width: MediaQuery.of(context).size.width*0.4,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Container(height: 130,
                                                    width: MediaQuery.of(context).size.width*0.4,
                                                    color: Colors.grey.withOpacity(0.5),
                                                    child: IconButton(
                                                      onPressed:()async{
                                                        widget.store.img1  =  await getImage() ;
                                                        if(widget.store.img1 !=null){setState(() {
                                                        });}
                                                      } ,
                                                      icon: const Icon(Icons.upload,
                                                        color: Colors.black54,
                                                        size: 30.0,
                                                      ),),
                                                  ),
                                                ],

                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text(widget.store.card_type_radio==1 ? 'Citizenship front page':'Pan front page' ,
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
                                            width: MediaQuery.of(context).size.width*0.4,
                                            child:  Center(
                                              child: widget.store.img2  == null ?IconButton(
                                                onPressed:()async{
                                                  widget.store.img2 =  await getImage() ;
                                                  if(widget.store.img2!=null){setState(() {
                                                  });}
                                                } ,
                                                icon: const Icon(Icons.upload,
                                                  color: Colors.grey,
                                                  size: 30.0,
                                                ),):
                                              Stack(
                                                children: <Widget>[
                                                  Image.file(File(widget.store.img2!.path).absolute,
                                                    height: 130,
                                                    width: MediaQuery.of(context).size.width*0.4,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Container(height: 130,
                                                    width: MediaQuery.of(context).size.width*0.4,
                                                    color: Colors.grey.withOpacity(0.5),
                                                    child: IconButton(
                                                      onPressed:()async{
                                                        widget.store.img2  =  await getImage() ;
                                                        if(widget.store.img2 !=null){setState(() {
                                                        });}
                                                      } ,
                                                      icon: const Icon(Icons.upload,
                                                        color: Colors.black54,
                                                        size: 30.0,
                                                      ),),
                                                  ),
                                                ],

                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text(widget.store.card_type_radio==1 ? 'Citizenship back page':'Pan back page',
                                            style: Theme.of(context).textTheme.caption,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 23.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        DottedBorder(
                                          dashPattern: const [4, 4],
                                          strokeWidth: 2,
                                          child: SizedBox(
                                            height: 130,
                                            width: MediaQuery.of(context).size.width*0.4,
                                            child:  Center(
                                              child: widget.store.img3  == null ?IconButton(
                                                onPressed:()async{
                                                  widget.store.img3  =  await getImage() ;
                                                  if(widget.store.img3!=null){setState(() {
                                                  });}
                                                } ,
                                                icon: const Icon(Icons.upload,
                                                  color: Colors.grey,
                                                  size: 30.0,
                                                ),):
                                              Stack(
                                                children: <Widget>[
                                                  Image.file(File(widget.store.img3!.path).absolute,
                                                    height: 130,
                                                    width: MediaQuery.of(context).size.width*0.4,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Container(height: 130,
                                                    width: MediaQuery.of(context).size.width*0.4,
                                                    color: Colors.grey.withOpacity(0.5),
                                                    child: IconButton(
                                                      onPressed:()async{
                                                        widget.store.img3 =  await getImage() ;
                                                        if(widget.store.img3!=null){setState(() {
                                                        });}
                                                      } ,
                                                      icon: const Icon(Icons.upload,
                                                        color: Colors.black54,
                                                        size: 30.0,
                                                      ),),
                                                  ),
                                                ],

                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text('Billbook main page' ,
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
                                            width: MediaQuery.of(context).size.width*0.4,
                                            child:  Center(
                                              child: widget.store.img4 == null ?IconButton(
                                                onPressed:()async{
                                                  widget.store.img4 =  await getImage() ;
                                                  if(widget.store.img4!=null){setState(() {
                                                  });}
                                                } ,
                                                icon: const Icon(Icons.upload,
                                                  color: Colors.grey,
                                                  size: 30.0,
                                                ),):
                                              Stack(
                                                children: <Widget>[
                                                  Image.file(File(widget.store.img4!.path).absolute,
                                                    height: 130,
                                                    width: MediaQuery.of(context).size.width*0.4,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Container(height: 130,
                                                    width: MediaQuery.of(context).size.width*0.4,
                                                    color: Colors.grey.withOpacity(0.5),
                                                    child: IconButton(
                                                      onPressed:()async{
                                                        widget.store.img4 =  await getImage() ;
                                                        if(widget.store.img4!=null){setState(() {
                                                        });}
                                                      } ,
                                                      icon: const Icon(Icons.upload,
                                                        color: Colors.black54,
                                                        size: 30.0,
                                                      ),),
                                                  ),
                                                ],

                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text('Billbook renewal page',
                                            style: Theme.of(context).textTheme.caption,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 23.0,),
                                Column(
                                  children: [
                                    DottedBorder(
                                      dashPattern: const [4, 4],
                                      strokeWidth: 2,
                                      child: SizedBox(
                                        height: 130,
                                        width: MediaQuery.of(context).size.width*0.4,
                                        child:  Center(
                                          child: widget.store.img5 == null ?IconButton(
                                            onPressed:()async{
                                              widget.store.img5  =  await getImage() ;
                                              if(widget.store.img5 !=null){
                                                setState(() {
                                                });
                                              }
                                            } ,
                                            icon: const Icon(Icons.upload,
                                              color: Colors.grey,
                                              size: 30.0,
                                            ),):
                                          Stack(
                                            children: <Widget>[
                                              Image.file(File(widget.store.img5 !.path).absolute,
                                                height: 130,
                                                width: MediaQuery.of(context).size.width*0.4,
                                                fit: BoxFit.cover,
                                              ),
                                              Container(height: 130,
                                                width: MediaQuery.of(context).size.width*0.4,
                                                color: Colors.grey.withOpacity(0.5),
                                                child: IconButton(
                                                  onPressed:()async {
                                                    widget.store.img5  = await getImage();
                                                    if (widget.store.img5  != null) {
                                                      setState(() {});}
                                                  },
                                                  icon: const Icon(Icons.upload,
                                                    color: Colors.black54,
                                                    size: 30.0,
                                                  ),),
                                              ),
                                            ],

                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text('Billbook tax last renewal date page' ,
                                        style: Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height:25.0 ,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.white),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.zero,
                                                    side: BorderSide(color: Colors.grey)
                                                )
                                            )
                                        ),
                                        child:  Text('Back',style: Theme.of(context).textTheme.button!.copyWith(color: Colors.grey))),
                                    const SizedBox(width: 10.0,),
                                    TextButton(
                                        onPressed: ()async{
                                          // if(widget.store.number_plate_radio == 1)
                                          // {widget.store.vehicle_no ='${widget.store.zonal_code}-${widget.store.lot_number}-${widget.store.v_type} ${widget.store.v_no} ';}
                                          //
                                          // else if(widget.store.number_plate_radio == 2)
                                          // {widget.store.vehicle_no ='${widget.store.province}-${widget.store.office_code}-${widget.store.lot_number} ${widget.store.symbol} ${widget.store.v_no} ';}
                                          //
                                          // print(widget.store.nid_no);
                                          //     print(widget.store.no_of_transfer);
                                          //   print(widget.store.purchase_year);
                                          //   print(widget.store.no_of_seats);
                                          //   print(widget.store.img1);
                                          //   print(widget.store.engine_no);
                                          //   print(widget.store.vehicle_name_id);
                                          //   print(widget.store.brand_id);
                                          //   print(widget.store.nid_type);
                                          //   print(widget.store.vehicle_no);
                                          //   print(widget.store.vehicle_type);
                                          //   print(widget.store.color);
                                          //   print(widget.store.phone_no);
                                          //   print(widget.store.address);
                                          //   print(widget.store.manufacture_year);
                                          //

                                          if(_formkey.currentState!.validate()){
                                            _formkey.currentState!.save();
                                           if(widget.store.number_plate_radio == 1)
                                           {widget.store.vehicle_no ='${widget.store.zonal_code}-${widget.store.lot_number}-${widget.store.v_type} ${widget.store.v_no} ';}

                                           else if(widget.store.number_plate_radio == 2)
                                           {widget.store.vehicle_no ='${widget.store.province}-${widget.store.office_code}-${widget.store.lot_number} ${widget.store.symbol} ${widget.store.v_no} ';}

                                            print('Client Side Validated');
                                            final snackBar = SnackBar(
                                                backgroundColor: Theme.of(context).colorScheme.primary,
                                                content:Text('Please Wait.....(Sending data to API)'));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            var uri = Uri.parse('https://aavissmotors.creatudevelopers.com.np/api/v1/save-vehicle');
                                            var request = http.MultipartRequest('POST', uri);
                                            request.headers.addAll({
                                              "Content-Type":"multipart/form-data",
                                              "Accept":"application/json",
                                            });
                                            request.fields.addAll({
                                              'full_name': '${widget.store.full_name}',
                                              'address':'${widget.store.address}',
                                              'phone_no': '${widget.store.phone_no}',
                                              'brand_id':'${widget.store.brand_id}',
                                              'vehicle_name_id': '${widget.store.vehicle_name_id}',
                                              'engine_no': '${widget.store.engine_no}',
                                              'manufacture_year': '${widget.store.manufacture_year}',
                                              'color': '${widget.store.color}',
                                              'no_of_seats':'${widget.store.no_of_seats}',
                                              'purchase_year': '${widget.store.purchase_year}',
                                              'no_of_transfer': '${widget.store.no_of_transfer}',
                                              'vehicle_type': '${widget.store.vehicle_type}',
                                              'vehicle_no': '${widget.store.vehicle_no}',
                                              'nid_type': '${widget.store.nid_type}',
                                              'nid_no': '${widget.store.nid_no}',
                                            });
                                            request.files.add(await http.MultipartFile.fromPath("nid_front", widget.store.img1!.path));
                                          request.files.add(await http.MultipartFile.fromPath("nid_back", widget.store.img2!.path));
                                          request.files.add(await http.MultipartFile.fromPath("bill_book_main_page", widget.store.img3!.path));
                                          request.files.add(await http.MultipartFile.fromPath("bill_book_renewal_page", widget.store.img4!.path));
                                          request.files.add(await http.MultipartFile.fromPath("bill_book_tax_renewed_date_page", widget.store.img5!.path));

                                          var response = await request.send() ;

                                            Map<String,dynamic> valueMap = json.decode( await response.stream.bytesToString());
                                            StoreResponseModel responseModel = StoreResponseModel.fromJson(valueMap);

                                            final snackBar1 = SnackBar(
                                                backgroundColor: Theme.of(context).colorScheme.primary,
                                                content:Text('${responseModel.message}'));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar1);

                                            if(response.statusCode == 200){
                                              print('Sent');
                                            if(responseModel.status == true )
                                                    {
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FinishScreen(title: widget.title,)));
                                                    }
                                          }
                                          else {
                                            if(response.statusCode == 500){
                                              final snackBar2 = SnackBar(
                                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                                  content:Text('${responseModel.message}'));
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar2);}

                                            else {
                                              String error = await response.stream.bytesToString();
                                              final snackBar = SnackBar(
                                                  backgroundColor:Theme.of(context).colorScheme.primary,
                                                  content: Text(error));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                            print('failed');
                                          }

                                          }


                                        },
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.white),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.zero,
                                                    side: BorderSide(color: Theme.of(context).colorScheme.secondary)
                                                )
                                            )
                                        ),
                                        child:  Text('Finish',style: Theme.of(context).textTheme.button)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ))),
              ),
              SizedBox(height: 34.0,width: MediaQuery.of(context).size.width,),

            ],
          ),
        ),
      ),
    );
  }
}
