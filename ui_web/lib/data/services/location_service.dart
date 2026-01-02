import 'package:dio/dio.dart';
import 'package:ui_web/data/model/location_model.dart';

class LocationService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://provinces.open-api.vn/api'),
  );

  Future<List<LocationModel>> getProvinces() async {
    final response = await _dio.get('/p/');
    return (response.data as List)
        .map((e) => LocationModel.fromJson(e))
        .toList();
  }

  Future<List<LocationModel>> getDistricts(int provinceCode) async {
    final response = await _dio.get('/p/$provinceCode?depth=2');
    return (response.data['districts'] as List)
        .map((e) => LocationModel.fromJson(e))
        .toList();
  }

  Future<List<LocationModel>> getWards(int districtCode) async {
    final response = await _dio.get('/d/$districtCode?depth=2');
    return (response.data['wards'] as List)
        .map((e) => LocationModel.fromJson(e))
        .toList();
  }
}
