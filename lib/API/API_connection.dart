import 'package:aaviss_motors/models/getvariants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/getbrand.dart';
import '../models/getvehiclename.dart';
import '../models/searchvehicle.dart';

class APIService {
  Future<BrandResponseModel?> getbrand() async {
    const String url1 = 'https://cms.aavissmotors.com/api/v1/get-brands';
    final response = await http.get(
      Uri.parse(url1),
    );
    if (response.statusCode == 200) {
      BrandResponseModel responseModel = BrandResponseModel.fromJson(
          json.decode(response
              .body)); //fromJson ----> firta deko lai user ra token ma map garne or error ma
      return responseModel;
    } else {
      throw Exception('Error fetching data');
    }
  }

  Future<VehicleResponseModel> getvehicle() async {
    const String url = 'https://cms.aavissmotors.com/api/v1/get-vehicle-names';
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      VehicleResponseModel responseModel =
          VehicleResponseModel.fromJson(json.decode(response.body));
      return responseModel;
    } else {
      throw Exception('Error fetching data');
    }
  }

  Future<VariantResponseModel> getvariant() async {
    const String url = 'https://cms.aavissmotors.com/api/v1/get-variants';
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      VariantResponseModel responseModel =
          VariantResponseModel.fromJson(json.decode(response.body));
      return responseModel;
    } else {
      throw Exception('Error fetching data');
    }
  }

  Future<SearchResponseModel?> searchvehicle(
      SearchRequestModel requestModel) async {
    final String url =
        'https://cms.aavissmotors.com/api/v1/search-vehicle?engine_no=${requestModel.vehicle_number}';
    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      SearchResponseModel responseModel =
          SearchResponseModel.fromJson(json.decode(response.body));
      return responseModel;
    } else {
      throw Exception('Error fetching data');
    }
  }
}
