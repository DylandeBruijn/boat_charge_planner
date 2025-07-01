import 'package:http/http.dart' as http;

class CarbonIntensityApiService {
  static const String _baseUrl = 'api.carbonintensity.org.uk';

  Future<http.Response> fetchTodaysCarbonIntensity() async {
    final Uri uri = Uri.https(_baseUrl, '/intensity/date');
    return await http.get(uri);
  }
}
