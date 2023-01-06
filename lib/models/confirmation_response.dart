
class StoreResponseModel {
  String? message;
  bool? status;
  StoreResponseModel({this.message,this.status});

  factory StoreResponseModel.fromJson(Map<String, dynamic> json) => StoreResponseModel(
    message: json["message"],
    status: json["status"],

  );
}
