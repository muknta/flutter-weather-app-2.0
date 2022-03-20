import 'package:weather_app_2_0/data/api/rest_api/services/settings/config.dart';

class GetRequestBody {
  const GetRequestBody({
    required this.latitude,
    required this.longitude,
    required this.language,
  });

  final double latitude;
  final double longitude;
  final String language;

  Map<String, dynamic> toDailyApi() => {
        'appid': openWeatherMapAppId,
        'units': 'metric',
        'exclude': 'minutely,hourly',
        'lat': latitude,
        'lon': longitude,
        'lang': language,
      };

  Map<String, dynamic> toHourlyApi() => {
        'appid': openWeatherMapAppId,
        'units': 'metric',
        'exclude': 'minutely,daily',
        'lat': latitude,
        'lon': longitude,
        'lang': language,
      };
}
