import 'dart:io';

import 'package:aaviss_motors/models/getbrand.dart';
import 'package:aaviss_motors/models/getvehiclename.dart';

class Store{
  String? full_name, address,phone_no,color,vehicle_type,vehicle_no,nid_type,
  brand_id,vehicle_name_id,engine_no,manufacture_year,no_of_seats,purchase_year,no_of_transfer,nid_no;

  File? img1,img2,img3,img4,img5;

  //String? vehicle_value;
  //String? brand_value;
  int? vehicle_type_radio,number_plate_radio;
  String? zonal_code,lot_number,v_type,v_no;
  String? province,office_code,symbol;
  int? card_type_radio;
  String? citizenship_no,pan_no;


Store({this.brand_id,this.color,this.address,this.engine_no,this.full_name,this.manufacture_year,
this.nid_no,this.nid_type,this.no_of_seats,this.no_of_transfer,this.phone_no,this.purchase_year,this.vehicle_name_id,
  this.vehicle_no,this.vehicle_type,

  //this.brand_value,  this.vehicle_value,
  this.vehicle_type_radio,this.number_plate_radio,

  this.zonal_code,this.lot_number,this.v_type,this.v_no,
  this.province,this.office_code,this.symbol,
  this.card_type_radio,
  this.img1,this.img2,this.img3,this.img4,this.img5,

  this.citizenship_no,this.pan_no
});
}

class B_V_fromAPI{
  List<Innerdata>? brandlist;
  List<innerdata>? vehiclelist;
  B_V_fromAPI({this.brandlist,this.vehiclelist,});
}