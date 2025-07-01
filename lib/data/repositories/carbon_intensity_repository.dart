import 'dart:convert';
import 'package:boat_charge_planner/data/models/carbon_intensity.dart';
import 'package:boat_charge_planner/data/services/carbon_intensity_api_service.dart';
import 'package:http/http.dart' as http;

class CarbonIntensityApiRepository {
  final CarbonIntensityApiService _apiService = CarbonIntensityApiService();

  Future<List<CarbonIntensity>> getTodaysCarbonIntensity() async {
    final http.Response response = await _apiService
        .fetchTodaysCarbonIntensity();

    if (response.statusCode == 200) {
      final successResponse = CarbonIntensityApiResponse.fromJson(
        jsonDecode(response.body),
      );
      return successResponse.data;
    } else {
      final errorResponse = CarbonIntensityApiErrorResponse.fromJson(
        jsonDecode(response.body),
      );
      throw Exception(
        'API Error ${response.statusCode} (${errorResponse.error.code}): ${errorResponse.error.message}',
      );
    }
  }
}
