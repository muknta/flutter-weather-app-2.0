import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';

abstract class ILocalRepository {
  const ILocalRepository();

  Future<List<Day>> getDailyContent();

  Future<List<Hour>> getHourlyContent();

  Future<bool> setDailyContent({required List<Day> content});

  Future<bool> setHourlyContent({required List<Hour> content});

  Future<bool> deleteDailyContent();

  Future<bool> deleteHourlyContent();
}
