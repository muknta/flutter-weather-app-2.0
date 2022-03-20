import 'package:weather_app_2_0/domain/model/day/day.dart';

abstract class DailyRepository {
  const DailyRepository();

  Future<List<Day>> getDaily({
    required double latitude,
    required double longitude,
    required String language,
  });
}
