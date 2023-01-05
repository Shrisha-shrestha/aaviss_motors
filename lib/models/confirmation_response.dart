
class StoreResponseModel {
  String? message;
  String? status;
  StoreResponseModel({this.message,this.status});

  factory StoreResponseModel.fromJson(Map<String, dynamic> json) => StoreResponseModel(
    message: json["message"],
    status: json["status"],

  );
}
