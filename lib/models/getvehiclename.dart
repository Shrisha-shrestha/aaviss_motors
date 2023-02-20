class VehicleResponseModel {
  outerdata? data;
  VehicleResponseModel({this.data,});

  factory VehicleResponseModel.fromJson(Map<String, dynamic> json) => VehicleResponseModel(
    data: outerdata.fromJson(json["data"]),
  );

}

class outerdata {
  VehicleNames? vehicleNames;
  outerdata({this.vehicleNames,});

  factory outerdata.fromJson(Map<String, dynamic> json) => outerdata(
    vehicleNames: VehicleNames.fromJson(json["vehicle_names"]),
  );

}

class VehicleNames {
  List<innerdata>? data;
  int? total;
  VehicleNames({this.data,this.total,});

  factory VehicleNames.fromJson(Map<String, dynamic> json) => VehicleNames(
    data: List<innerdata>.from(json["data"].map((x) => innerdata.fromJson(x))),
    total: json["total"],
  );

}

class innerdata {
  int? id;
  String? brandId;
  String? vehicleName;
  innerdata({this.id,this.brandId,this.vehicleName,});
  factory innerdata.fromJson(Map<String, dynamic> json) => innerdata(
    id: json["id"],
    brandId: json["brand_id"],
    vehicleName: json["vehicle_name"],
  );

}
