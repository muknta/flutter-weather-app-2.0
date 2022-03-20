import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';

abstract class IRemoteDataSource {
  Future<List<Day>> getDaily({
    required double latitude,
    required double longitude,
    required String language,
  });

  Future<List<Hour>> getHourly({
    required double latitude,
    required double longitude,
    required String language,
  });
}