import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';

abstract class IRemoteDataSource {
  Future<List<Day>> fetchDailyContent({
    required double latitude,
    required double longitude,
    required String language,
  });

  Future<List<Hour>> fetchHourlyContent({
    required double latitude,
    required double longitude,
    required String language,
  });
}
