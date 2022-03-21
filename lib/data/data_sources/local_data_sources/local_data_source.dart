import 'package:injectable/injectable.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/dao/day_sqflite_dao.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/dao/hour_sqflite_dao.dart';
import 'package:weather_app_2_0/data/api/model/day/day_table_model.dart';
import 'package:weather_app_2_0/data/api/model/hour/hour_table_model.dart';
import 'package:weather_app_2_0/data/data_sources/local_data_sources/i_local_data_source.dart';
import 'package:weather_app_2_0/data/mapper/day/daily_mapper.dart';
import 'package:weather_app_2_0/data/mapper/hour/hourly_mapper.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';

@LazySingleton(as: ILocalDataSource)
class LocalDataSource implements ILocalDataSource {
  const LocalDataSource({
    required HourSqfliteDao hourSqfliteDao,
    required DaySqfliteDao daySqfliteDao,
  })  : _hourSqfliteDao = hourSqfliteDao,
        _daySqfliteDao = daySqfliteDao;

  final HourSqfliteDao _hourSqfliteDao;
  final DaySqfliteDao _daySqfliteDao;

  @override
  Future<List<Day>> getDailyContent() async {
    final List<Map<String, dynamic>> mapDayList = await _daySqfliteDao.getAllDays();
    final dayTableList = <DayTableModel>[];
    for (final map in mapDayList) {
      dayTableList.add(DayTableModel.fromJson(map));
    }
    return DailyMapper.fromTableModel(dayTableList);
  }

  @override
  Future<List<Hour>> getHourlyContent() async {
    final List<Map<String, dynamic>> mapHourList = await _hourSqfliteDao.getAllHours();
    final hourTableList = <HourTableModel>[];
    for (final map in mapHourList) {
      hourTableList.add(HourTableModel.fromJson(map));
    }
    return HourlyMapper.fromTableModel(hourTableList);
  }

  @override
  Future<bool> setDailyContent({required List<Day> content}) async {
    final List<DayTableModel> dayTableList = DailyMapper.toTableModel(content);
    final mapList = <Map<String, dynamic>>[];
    for (final dayTable in dayTableList) {
      mapList.add(dayTable.toJson());
    }
    return (await _daySqfliteDao.insertAll(days: mapList)).every((isCorrectExit) => isCorrectExit);
  }

  @override
  Future<bool> setHourlyContent({required List<Hour> content}) async {
    final List<HourTableModel> hourTableList = HourlyMapper.toTableModel(content);
    final mapList = <Map<String, dynamic>>[];
    for (final hourTable in hourTableList) {
      mapList.add(hourTable.toJson());
    }
    return (await _hourSqfliteDao.insertAll(hours: mapList)).every((isCorrectExit) => isCorrectExit);
  }
}
