class BrandResponseModel {
  Data? outerdata;
  BrandResponseModel({this.outerdata,});
  factory BrandResponseModel.fromJson(Map<String, dynamic> json) =>
      BrandResponseModel(
        outerdata: Data.fromJson(json["data"]),
      );
}

class Data {
  Brands? brands;
  Data({this.brands,});
  factory Data.fromJson(Map<String, dynamic> json) => Data(
    brands: Brands.fromJson(json["brands"]),
  );
}


class Brands {
  List<Innerdata>? innerdata;
  int? total;
  Brands({this.innerdata,this.total,});
  factory Brands.fromJson(Map<String, dynamic> json) => Brands(
    innerdata: List<Innerdata>.from(json["data"].map((x) => Innerdata.fromJson(x))),
    total: json["total"],
  );

}

class Innerdata {
  int? id;
  String? name;
  Innerdata({this.id,this.name,});

  factory Innerdata.fromJson(Map<String, dynamic> json) => Innerdata(
    id: json["id"],
    name: json["name"],
  );
}
