import 'package:weather_app_2_0/domain/model/hour/hour.dart';

abstract class HourlyRepository {
  const HourlyRepository();

  Future<List<Hour>> getHourly({
    required double latitude,
    required double longitude,
    required String language,
  });
}
