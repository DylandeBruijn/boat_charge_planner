class Intensity {
  final int forecast;
  final int? actual;
  final String index;

  Intensity({required this.forecast, this.actual, required this.index});

  factory Intensity.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'forecast': int forecast,
        'actual': int? actual,
        'index': String index,
      } =>
        Intensity(forecast: forecast, actual: actual, index: index),
      _ => throw FormatException('Invalid JSON format for Intensity'),
    };
  }
}

class CarbonIntensity {
  final DateTime from;
  final DateTime to;
  final Intensity intensity;

  CarbonIntensity({
    required this.from,
    required this.to,
    required this.intensity,
  });

  factory CarbonIntensity.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'from': String from,
        'to': String to,
        'intensity': Map<String, dynamic> intensity,
      } =>
        CarbonIntensity(
          from: DateTime.parse(from),
          to: DateTime.parse(to),
          intensity: Intensity.fromJson(intensity),
        ),
      _ => throw FormatException('Invalid JSON format for CarbonIntensity'),
    };
  }
}

class CarbonIntensityApiError {
  final String code;
  final String message;

  CarbonIntensityApiError({required this.code, required this.message});

  factory CarbonIntensityApiError.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'code': String code, 'message': String message} =>
        CarbonIntensityApiError(code: code, message: message),
      _ => throw FormatException('Invalid JSON format for Error'),
    };
  }
}

class CarbonIntensityApiResponse {
  final List<CarbonIntensity> data;

  CarbonIntensityApiResponse({required this.data});

  factory CarbonIntensityApiResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'data': List<dynamic> data} => CarbonIntensityApiResponse(
        data: data
            .map(
              (item) => CarbonIntensity.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
      ),
      _ => throw FormatException(
        'Invalid JSON format for CarbonIntensityResponse',
      ),
    };
  }
}

class CarbonIntensityApiErrorResponse {
  final CarbonIntensityApiError error;

  CarbonIntensityApiErrorResponse({required this.error});

  factory CarbonIntensityApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'error': Map<String, dynamic> error} => CarbonIntensityApiErrorResponse(
        error: CarbonIntensityApiError.fromJson(error),
      ),
      _ => throw FormatException('Invalid JSON format for ErrorResponse'),
    };
  }
}
