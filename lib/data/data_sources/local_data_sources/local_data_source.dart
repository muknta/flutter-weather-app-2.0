import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/dao/day_sqflite_dao.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/dao/hour_sqflite_dao.dart';
import 'package:weather_app_2_0/data/api/helpers/day/api_daily.dart';
import 'package:weather_app_2_0/data/api/model/day/api_day.dart';
import 'package:weather_app_2_0/data/api/rest_api/interceptors/dio_error_interceptor.dart';
import 'package:weather_app_2_0/data/api/rest_api/request/get_request_body.dart';
import 'package:weather_app_2_0/data/data_sources/local_data_sources/i_local_data_source.dart';
import 'package:weather_app_2_0/data/mapper/day/daily_mapper.dart';
import 'package:weather_app_2_0/data/mapper/hour/hourly_mapper.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:flutter/foundation.dart';

@LazySingleton(as: ILocalDataSource)
class LocalDataSource implements ILocalDataSource {
  LocalDataSource() {
    required HourSqfliteDao hourSqfliteDao
    required DaySqfliteDao daySqfliteDao,
  })  : _hourSqfliteDao = hourSqfliteDao
        _daySqfliteDao = daySqfliteDao;

  final HourSqfliteDao _hourSqfliteDao;
  final DaySqfliteDao _daySqfliteDao;


  // TODO:
  @override
  Future<List<Day>> getDailyContent() {
    final mapDayList = _daySqfliteDao.getAllDays();
    final res =  ApiDaily.fromApi(mapDayList);
    return DailyMapper.fromApi(dayList);
  }
  Future<void> setDailyContent({required List<Day> content});

  Future<List<Hour>> getHourlyContent();
  Future<void> setHourlyContent({required List<Hour> content});
}
