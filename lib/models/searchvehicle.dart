class SearchRequestModel {
  String? vehicle_number;
  SearchRequestModel({this.vehicle_number});
}

class SearchResponseModel {
  SearchResponseModel({
    this.data,
  });

  Data? data;

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) =>
      SearchResponseModel(
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.vehicle,
  });

  Vehicle? vehicle;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        vehicle:
            json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
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
    this.variantId,
    this.engineNo,
    this.manufactureYear,
    this.color,
    this.noOfSeats,
    this.purchaseYear,
    this.noOfTransfer,
    this.kilometer,
    this.vehicleType,
    this.vehicleNo,
    this.majorAccident,
    this.serviceHistory,
    this.nidType,
    this.nidNo,
    this.nidFront,
    this.nidBack,
    this.billBookMainPage,
    this.billBookRenewalPage,
    this.billBookTaxRenewedDatePage,
    this.status,
    this.brand,
    this.vehicleName,
    this.variantName,
  });

  int? id;
  String? fullName;
  String? address;
  String? phoneNo;
  String? brandId;
  String? vehicleNameId;
  String? variantId;
  String? engineNo;
  String? manufactureYear;
  String? color;
  String? noOfSeats;
  String? purchaseYear;
  String? noOfTransfer;
  String? kilometer;
  String? vehicleType;
  String? vehicleNo;
  String? majorAccident;
  String? serviceHistory;
  String? nidType;
  String? nidNo;
  String? nidFront;
  String? nidBack;
  String? billBookMainPage;
  String? billBookRenewalPage;
  String? billBookTaxRenewedDatePage;
  String? status;
  Brand? brand;
  VehicleName? vehicleName;
  VariantName? variantName;

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json["id"],
      fullName: json["full_name"],
      address: json["address"],
      phoneNo: json["phone_no"],
      brandId: json["brand_id"],
      vehicleNameId: json["vehicle_name_id"],
      variantId: json["variant_id"],
      engineNo: json["engine_no"],
      manufactureYear: json["manufacture_year"],
      color: json["color"],
      noOfSeats: json["no_of_seats"],
      purchaseYear: json["purchase_year"],
      noOfTransfer: json["no_of_transfer"],
      kilometer: json["kilometer"],
      vehicleType: json["vehicle_type"],
      vehicleNo: json["vehicle_no"],
      majorAccident: json["major_accident"],
      serviceHistory: json["service_history"],
      nidType: json["nid_type"],
      nidNo: json["nid_no"],
      nidFront: json["nid_front"],
      nidBack: json["nid_back"],
      billBookMainPage: json["bill_book_main_page"],
      billBookRenewalPage: json["bill_book_renewal_page"],
      billBookTaxRenewedDatePage: json["bill_book_tax_renewed_date_page"],
      status: json["status"],
      brand: Brand.fromJson(json["brand"]),
      vehicleName: VehicleName.fromJson(json["vehicle_name"]),
      variantName: VariantName.fromJson(json["variant"]),
    );
  }
}

class Brand {
  Brand({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
      );
}

class VehicleName {
  VehicleName({
    this.id,
    this.brandId,
    this.vehicleName,
  });

  int? id;
  String? brandId;
  String? vehicleName;

  factory VehicleName.fromJson(Map<String, dynamic> json) => VehicleName(
        id: json["id"],
        brandId: json["brand_id"],
        vehicleName: json["vehicle_name"],
      );
}

class VariantName {
  VariantName({
    this.id,
    this.vehiclenameid,
    this.variantName,
  });

  int? id;
  String? vehiclenameid;
  String? variantName;

  factory VariantName.fromJson(Map<String, dynamic> json) => VariantName(
        id: json["id"],
        vehiclenameid: json["vehicle_name_id"],
        variantName: json["variant_name"],
      );
}
