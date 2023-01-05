class SearchRequestModel {
  String? vehicle_number;
  SearchRequestModel({ this.vehicle_number});

}

class SearchResponseModel {
  SearchResponseModel({
    this.status,
    this.message,
    this.statusCode,
    this.data,
  });

  bool? status;
  String? message;
  int? statusCode;
  Data? data;

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) => SearchResponseModel(
    status: json["status"],
    message: json["message"],
    statusCode: json["status_code"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.vehicle,
    this.imageBaseUrl,
  });

  Vehicle? vehicle;
  String? imageBaseUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    vehicle: Vehicle.fromJson(json["vehicle"]),
    imageBaseUrl: json["image_base_url"],
  );

}

class Vehicle {
  Vehicle({
    this.id,
    this.fullName,
    this.address,
    this.phoneNo,
    this.brandId,
    this.vehicleNameId,
    this.engineNo,
    this.manufactureYear,
    this.color,
    this.noOfSeats,
    this.purchaseYear,
    this.noOfTransfer,
    this.vehicleType,
    this.vehicleNo,
    this.nidType,
    this.nidNo,
    this.nidFront,
    this.nidBack,
    this.billBookMainPage,
    this.billBookRenewalPage,
    this.billBookTaxRenewedDatePage,
    this.brand,
    this.vehicleName,
  });

  int? id;
  String? fullName;
  String? address;
  int? phoneNo;
  int? brandId;
  int? vehicleNameId;
  String? engineNo;
  String? manufactureYear;
  String? color;
  int? noOfSeats;
  String? purchaseYear;
  int? noOfTransfer;
  String? vehicleType;
  String? vehicleNo;
  String? nidType;
  String? nidNo;
  String? nidFront;
  String? nidBack;
  String? billBookMainPage;
  String? billBookRenewalPage;
  String? billBookTaxRenewedDatePage;
  String? brand;
  VehicleName? vehicleName;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json["id"],
    fullName: json["full_name"],
    address: json["address"],
    phoneNo: json["phone_no"],
    brandId: json["brand_id"],
    vehicleNameId: json["vehicle_name_id"],
    engineNo: json["engine_no"],
    manufactureYear: json["manufacture_year"],
    color: json["color"],
    noOfSeats: json["no_of_seats"],
    purchaseYear: json["purchase_year"],
    noOfTransfer: json["no_of_transfer"],
    vehicleType: json["vehicle_type"],
    vehicleNo: json["vehicle_no"],
    nidType: json["nid_type"],
    nidNo: json["nid_no"],
    nidFront: json["nid_front"],
    nidBack: json["nid_back"],
    billBookMainPage: json["bill_book_main_page"],
    billBookRenewalPage: json["bill_book_renewal_page"],
    billBookTaxRenewedDatePage: json["bill_book_tax_renewed_date_page"],
    brand: json["brand"],
    vehicleName: VehicleName.fromJson(json["vehicle_name"]),
  );

  }

class VehicleName {
  VehicleName({
    this.id,
    this.brandId,
    this.vehicleName,
  });

  int? id;
  int? brandId;
  String? vehicleName;

  factory VehicleName.fromJson(Map<String, dynamic> json) => VehicleName(
    id: json["id"],
    brandId: json["brand_id"],
    vehicleName: json["vehicle_name"],
  );
}
