import 'package:aaviss_motors/models/getvehiclename.dart';
import 'package:aaviss_motors/screens/legal_info.dart';
import 'package:aaviss_motors/screens/search_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/storevehicleinfo.dart';
import '../models/getbrand.dart';

class VehicleInfo extends StatefulWidget {
  const VehicleInfo({super.key, required this.title,required this.store,required this.bvinfoAPI});
  final String title;
  final Store store;
  final B_V_fromAPI bvinfoAPI;

  @override
  State<VehicleInfo> createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
 // int? brandid;
  // List<List<String>> vehicle= [['v1','v2'],['v3','v4']];
  //int? len;

  int? val1,val2 ;
  List<Innerdata> brands=[];
  List<innerdata> vehicles=[];
  dynamic val;
  late Future<List<String>> futurewidget;
  List<String> years=[];
  int? dropdownvalue1,dropdownvalue2;
  String? dropdownvalue3,dropdownvalue4;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isvisible1=false,_isvisible2=false;
String? errorinpurchase='',errorinvehicletype='',errorinnumbreplate='';
  // void  brandbasedvehicle(int brandId){
  //       setState(() {
  //      vehicles = vehicle[brandId];
  //    });
  // }
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
    brands=widget.bvinfoAPI.brandlist!;
    vehicles=widget.bvinfoAPI.vehiclelist!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: Theme.of(context).textTheme.headline5),
        // leading: Transform.translate(offset: Offset(-15, 0),),
        titleSpacing: -30,
        centerTitle: false,
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
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchDetail(title: widget.title)));
                }),
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
                padding: const EdgeInsets.only(top: 10,bottom: 34),
                child: Text('Fill the form below to know resale\nvalue of your vehicle',
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
                              height:20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(15.0)
                              ),
                              child: const Center(
                                child: Text('2',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 12.0
                                  ),
                                ),
                              )
                          ),
                          const SizedBox(width: 6.0,),
                          Text('Vehicle Information',
                            style:Theme.of(context).textTheme.bodyText1 ,),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Text('Vehicle Information',
                          style:Theme.of(context).textTheme.bodyText2 ,),
                      ),
                     Form(
                        key: _formkey,
                        child: Column(
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
                              value: dropdownvalue1,
                              items: brands.map((e) {
                                return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(
                                        style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                        textAlign: TextAlign.start,
                                        e.name ?? ''));
                              }).toList(),
                              icon: const Icon(Icons.arrow_drop_down,color:Colors.grey ,),
                              onChanged: (int? newValue) {
                                  dropdownvalue1 = newValue!;
                              },
                              onSaved: (int? value) {
                                //widget.store.brand_id = brands.indexOf(value!).toString();
                                widget.store.brand_id= value.toString();
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
                              value: dropdownvalue2,
                              icon: const Icon(Icons.arrow_drop_down,color:Colors.grey,),
                              items: vehicles.map((e) {
                                return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(
                                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                        textAlign: TextAlign.start,
                                        e.vehicleName ?? ''));
                              }).toList(),
                              onChanged: (int? newValue) {
                                dropdownvalue2 = newValue!;
                                },
                              onSaved: (int? value) {
                                widget.store.vehicle_name_id= value.toString();
                               // widget.store.vehicle_value =value;

                              },
                            ),
                            const SizedBox(height: 10.0,),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onSaved: (String? value) {
                                widget.store.engine_no = value;
                              },
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
                              value: dropdownvalue3,
                              icon: const Icon(Icons.arrow_drop_down,color:Colors.grey,),
                              items: years.map((String val) {
                                return DropdownMenuItem(
                                  alignment: Alignment.center,
                                  value: val,
                                  child: Text(val,style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize:18.0),),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                dropdownvalue3 = newValue!;
                                },
                              onSaved: (String? value) {
                                widget.store.manufacture_year = value;
                              },
                            ),
                            const SizedBox(height: 10.0,),
                            TextFormField(
                              onSaved: (String? value) {
                                widget.store.color = value;
                              },
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
                              onSaved: (String? value) {
                                widget.store.no_of_seats = value;
                              },
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
                              value: dropdownvalue4,
                              icon: const Icon(Icons.arrow_drop_down,color:Colors.grey,),
                              items: years.map((String val) {
                                return DropdownMenuItem(
                                  alignment: Alignment.center,
                                  value: val,
                                  child: Text(val,style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize:18.0),),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                dropdownvalue4 = newValue!;
                                                              },
                              onSaved: (String? value) {
                                widget.store.purchase_year = value;
                              },
                            ),
                             Padding(
                               padding: const EdgeInsets.only(top: 3.0),
                               child: SizedBox(height: 10.0,
                                  child:Text('$errorinpurchase',style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.red))),
                             ),

                            TextFormField(
                              keyboardType: TextInputType.number,
                              onSaved: (String? value) {
                                widget.store.no_of_transfer = value;
                              },
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
                                    groupValue: val1,
                                    activeColor: Theme.of(context).colorScheme.secondary,
                                    onChanged: (int? value){
                                      setState(() {
                                        val1 = value;
                                        widget.store.vehicle_type = 'private';
                                        widget.store.vehicle_type_radio=1;
                                      });
                                    }),
                                Text("Private",
                                    style: Theme.of(context).textTheme.caption),
                                const SizedBox(width: 70.0,),
                                Radio<int>(
                                    value: 2,
                                    groupValue: val1,
                                    activeColor: Theme.of(context).colorScheme.secondary,
                                    onChanged: (int? value){
                                      setState(() {
                                        val1 = value;
                                        widget.store.vehicle_type = 'public';
                                        widget.store.vehicle_type_radio=2;

                                      });
                                    }),
                                Text("Public",
                                    style: Theme.of(context).textTheme.caption),
                              ],
                            ),
                            SizedBox(height: 20.0,
                                child:Text('$errorinvehicletype',style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.red),)),
                            Text('Number PLate',
                              style: Theme.of(context).textTheme.caption,),
                            Row(
                              children: <Widget>[
                                Radio<int>(
                                    value: 1,
                                    groupValue: val2,
                                    activeColor: Theme.of(context).colorScheme.secondary,
                                    onChanged: (int? value){
                                      setState(() {
                                        val2 = value;
                                        _isvisible2=false;
                                        _isvisible1=true;
                                        widget.store.number_plate_radio=1;

                                      });
                                    }),
                                Text("Old",
                                    style: Theme.of(context).textTheme.caption),
                                const SizedBox(width: 91.0,),
                                Radio<int>(
                                    value: 2,
                                    groupValue: val2,
                                    activeColor: Theme.of(context).colorScheme.secondary,
                                    onChanged: (int? value){
                                      setState(() {
                                        val2 = value;
                                        _isvisible2=true;
                                        _isvisible1=false;
                                        widget.store.number_plate_radio=2;
                                      });
                                    }),
                                Text("New",
                                    style: Theme.of(context).textTheme.caption),
                              ],
                            ),
                            SizedBox(height: 20.0,
                                child:Text('$errorinnumbreplate',style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.red),)),
                            Visibility(
                              visible: _isvisible1,
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 91.0,
                                        child: TextFormField(
                                          onSaved: (String? value) {
                                            widget.store.zonal_code = value;
                                          },
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(fontSize: 18.0),
                                          validator: (val) =>
                                          val!.isEmpty
                                              ? 'Required!'
                                              : null,
                                          decoration: InputDecoration(
                                            labelText: 'Zonal Code',
                                            labelStyle: Theme
                                                .of(context)
                                                .textTheme
                                                .caption,
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey), //<-- SEE HERE
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 91.0,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          onSaved: (String? value) {
                                            widget.store.lot_number = value;
                                          },
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(fontSize: 18.0),
                                          validator: (val) =>
                                          val!.isEmpty
                                              ? 'Required!'
                                              : null,
                                          decoration: InputDecoration(
                                            labelText: 'Lot Number',
                                            labelStyle: Theme
                                                .of(context)
                                                .textTheme
                                                .caption,
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey), //<-- SEE HERE
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 91.0,
                                        child: TextFormField(
                                          onSaved: (String? value) {
                                            widget.store.v_type = value;
                                          },
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(fontSize: 18.0),
                                          validator: (val) =>
                                          val!.isEmpty
                                              ? 'Required!'
                                              : null,
                                          decoration: InputDecoration(
                                            labelText: 'Vehicle Type',
                                            labelStyle: Theme
                                                .of(context)
                                                .textTheme
                                                .caption,
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey), //<-- SEE HERE
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
                                      onSaved: (String? value) {
                                        widget.store.v_no = value;
                                      },
                                      textAlign: TextAlign.center,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(fontSize: 18.0),
                                      validator: (val) =>
                                      val!.isEmpty
                                          ? 'Required!'
                                          : null,
                                      decoration: InputDecoration(
                                        labelText: 'Vehicle Number',
                                        labelStyle: Theme
                                            .of(context)
                                            .textTheme
                                            .caption,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey), //<-- SEE HERE
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
                                          onSaved: (String? value) {
                                            widget.store.province = value;
                                          },
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(fontSize: 18.0),
                                          validator: (val) =>
                                          val!.isEmpty
                                              ? 'Required!'
                                              : null,
                                          decoration: InputDecoration(
                                            labelText: 'Province',
                                            labelStyle: Theme
                                                .of(context)
                                                .textTheme
                                                .caption,
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey), //<-- SEE HERE
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 91.0,
                                        child: TextFormField(
                                          onSaved: (String? value) {
                                            widget.store.office_code = value;
                                          },
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(fontSize: 18.0),
                                          validator: (val) =>
                                          val!.isEmpty
                                              ? 'Required!'
                                              : null,
                                          decoration: InputDecoration(
                                            labelText: 'Office Code',
                                            labelStyle: Theme
                                                .of(context)
                                                .textTheme
                                                .caption,
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey), //<-- SEE HERE
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 91.0,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          onSaved: (String? value) {
                                            widget.store.lot_number = value;
                                          },
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(fontSize: 18.0),
                                          validator: (val) =>
                                          val!.isEmpty
                                              ? 'Required!'
                                              : null,
                                          decoration: InputDecoration(
                                            labelText: 'Lot Number',
                                            labelStyle: Theme
                                                .of(context)
                                                .textTheme
                                                .caption,
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey), //<-- SEE HERE
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
                                          onSaved: (String? value) {
                                            widget.store.symbol = value;
                                          },
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(fontSize: 18.0),
                                          validator: (val) =>
                                          val!.isEmpty
                                              ? 'Required!'
                                              : null,
                                          decoration: InputDecoration(
                                            labelText: 'Symbol',
                                            labelStyle: Theme
                                                .of(context)
                                                .textTheme
                                                .caption,
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey), //<-- SEE HERE
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.1,),
                                      SizedBox(
                                        width: 91.0,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          onSaved: (String? value) {
                                            widget.store.v_no = value;
                                          },
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(fontSize: 18.0),
                                          validator: (val) =>
                                          val!.isEmpty
                                              ? 'Required!'
                                              : null,
                                          decoration: InputDecoration(
                                            labelText: 'Vehicle Number',
                                            labelStyle: Theme
                                                .of(context)
                                                .textTheme
                                                .caption,
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey), //<-- SEE HERE
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height:46.0 ,),
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
                                    onPressed: (){
                                      if(_formkey.currentState!.validate()){
                                        if(val1!=null ) {
                                          setState(() {
                                            errorinvehicletype='';
                                          });
                                          if(val2!=null){
                                            setState(() {
                                              errorinnumbreplate='';
                                            });
                                            if(int.parse(dropdownvalue3!) <= int.parse(dropdownvalue4!)){
                                              errorinpurchase='';
                                              _formkey.currentState!.save();
                                              if (kDebugMode) {
                                                print('Client Side Validated');
                                              }
                                              if(widget.store.number_plate_radio == 1)
                                              {widget.store.vehicle_no ='${widget.store.zonal_code}-${widget.store.lot_number}-${widget.store.v_type} ${widget.store.v_no} ';}

                                              else if(widget.store.number_plate_radio == 2)
                                              {widget.store.vehicle_no ='${widget.store.province}-${widget.store.office_code}-${widget.store.lot_number} ${widget.store.symbol} ${widget.store.v_no} ';}

                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                                  LegalInfo(title: widget.title,store: widget.store,bvinfoAPI:widget.bvinfoAPI)));

                                            }
                                            else{
                                              setState(() {
                                                errorinpurchase = 'Purchase Year cannot be before Manufacture Year';
                                              });
                                            }
                                          }
                                          else{
                                                setState(() {
                                                errorinnumbreplate = 'Please select one';
                                                        });
                                                  }
                                          }
                                        }
                                        else{
                                          setState(() {
                                             errorinvehicletype = 'Please select one';
                                                });
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
                                    child:  Text('Next',style: Theme.of(context).textTheme.button)),
                              ],
                            ),
                          ],
                        ),
                      ),

              SizedBox(height: 34.0,width: MediaQuery.of(context).size.width,),
                    ]
                  ),
                ),
        ),
            ],
          ),
        ),
      ),
    );
  }
}

