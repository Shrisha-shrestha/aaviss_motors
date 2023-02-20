class VariantResponseModel {
  VariantResponseModel({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  Data? data;

  factory VariantResponseModel.fromJson(Map<String, dynamic> json) =>
      VariantResponseModel(
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.variants,
  });

  Variants? variants;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        variants: Variants.fromJson(json["variants"]),
      );
}

class Variants {
  Variants({
    this.data,
    this.total,
  });

  List<inner_data>? data;
  int? total;

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
        data: json["data"] == null
            ? []
            : List<inner_data>.from(
                json["data"]!.map((x) => inner_data.fromJson(x))),
        total: json["total"],
      );
}

class inner_data {
  inner_data({
    this.id,
    this.vehicleNameId,
    this.variantName,
  });

  int? id;
  String? vehicleNameId;
  String? variantName;

  factory inner_data.fromJson(Map<String, dynamic> json) => inner_data(
        id: json["id"],
        vehicleNameId: json["vehicle_name_id"],
        variantName: json["variant_name"],
      );
}
