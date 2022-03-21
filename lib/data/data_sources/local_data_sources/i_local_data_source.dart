import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';

abstract class ILocalDataSource {
  Future<List<Day>> getDailyContent();
  Future<void> setDailyContent({required List<Day> content});

  Future<List<Hour>> getHourlyContent();
  Future<void> setHourlyContent({required List<Hour> content});
}
