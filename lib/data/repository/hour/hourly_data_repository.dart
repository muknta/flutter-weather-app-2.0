import 'package:weather_app_2_0/data/api/api_util.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/domain/repository/hour/hourly_repository.dart';

class HourlyDataRepository extends HourlyRepository {
  const HourlyDataRepository(this._apiUtil);

  final ApiUtil _apiUtil;

  @override
  Future<List<Hour>> getHourly({
    required double latitude,
    required double longitude,
    required String language,
  }) async =>
      _apiUtil.getHourly(latitude: latitude, longitude: longitude, language: language);
}
