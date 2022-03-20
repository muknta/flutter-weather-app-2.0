import 'package:weather_app_2_0/data/api/api_util.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/repository/day/daily_repository.dart';

class DailyDataRepository extends DailyRepository {
  const DailyDataRepository(this._apiUtil);

  final ApiUtil _apiUtil;

  @override
  Future<List<Day>> getDaily({
    required double latitude,
    required double longitude,
    required String language,
  }) async =>
      _apiUtil.getDaily(latitude: latitude, longitude: longitude, language: language);
}
