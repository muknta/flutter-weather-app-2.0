import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/dao/day_sqflite_dao.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/dao/hour_sqflite_dao.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/dao/settings_sqflite_dao.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/schemas/settings_sqflite_schema.dart';
import 'package:weather_app_2_0/data/api/model/coords_table_model.dart';
import 'package:weather_app_2_0/data/api/model/day/day_table_model.dart';
import 'package:weather_app_2_0/data/api/model/hour/hour_table_model.dart';
import 'package:weather_app_2_0/data/data_sources/local_data_sources/i_local_data_source.dart';
import 'package:weather_app_2_0/data/mapper/coords_model_mapper.dart';
import 'package:weather_app_2_0/data/mapper/day/daily_mapper.dart';
import 'package:weather_app_2_0/data/mapper/hour/hourly_mapper.dart';
import 'package:weather_app_2_0/domain/model/coords_model.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';

@LazySingleton(as: ILocalDataSource)
class LocalDataSource implements ILocalDataSource {
  const LocalDataSource({
    required HourSqfliteDao hourSqfliteDao,
    required DaySqfliteDao daySqfliteDao,
    required SettingsSqfliteDao settingsSqfliteDao,
  })  : _hourSqfliteDao = hourSqfliteDao,
        _daySqfliteDao = daySqfliteDao,
        _settingsSqfliteDao = settingsSqfliteDao;

  final HourSqfliteDao _hourSqfliteDao;
  final DaySqfliteDao _daySqfliteDao;
  final SettingsSqfliteDao _settingsSqfliteDao;

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
  Future<String?> getLanguage() async {
    final Map<String, dynamic>? langMap =
        await _settingsSqfliteDao.getColumnFieldByName(fieldName: SettingsSqfliteSchema.language);
    print('${langMap?[SettingsSqfliteSchema.language]} ------GET------ $langMap');
    return langMap?[SettingsSqfliteSchema.language];
  }

  @override
  Future<CoordsModel?> getCoordinates() async {
    final Map<String, dynamic>? positionMap =
        await _settingsSqfliteDao.getColumnFieldByName(fieldName: SettingsSqfliteSchema.position);
    final String? position = positionMap?[SettingsSqfliteSchema.position];
    if (position == null) {
      return null;
    }
    final Map<String, dynamic>? addressMap =
        await _settingsSqfliteDao.getColumnFieldByName(fieldName: SettingsSqfliteSchema.address);
    final String? address = addressMap?[SettingsSqfliteSchema.address];
    return CoordsModelMapper.fromTableModel(
        tableModel: CoordsTableModel(
      position: position,
      address: address,
    ));
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

  @override
  Future<bool> setLanguage({required String language}) async {
    final Map<String, dynamic>? immutableQueryRow = await _settingsSqfliteDao.getQueryRow();
    Map<String, dynamic>? mutableQueryRow;
    print('${immutableQueryRow?[SettingsSqfliteSchema.language]} ------SET------ $immutableQueryRow');
    if (immutableQueryRow == null || immutableQueryRow.isEmpty) {
      mutableQueryRow = <String, dynamic>{SettingsSqfliteSchema.language: language};
    } else {
      await _settingsSqfliteDao.deleteAll();
      mutableQueryRow = Map<String, dynamic>.of(immutableQueryRow);
      mutableQueryRow[SettingsSqfliteSchema.language] = language;
    }
    return _settingsSqfliteDao.insert(settings: mutableQueryRow);
  }

  @override
  Future<bool> setCoordinates({required CoordsModel coordsModel}) async {
    final Map<String, dynamic>? immutableQueryRow = await _settingsSqfliteDao.getQueryRow();
    Map<String, dynamic>? mutableQueryRow;
    final CoordsTableModel tableModel = CoordsModelMapper.toTableModel(model: coordsModel);
    if (immutableQueryRow == null || immutableQueryRow.isEmpty) {
      mutableQueryRow = <String, dynamic>{
        SettingsSqfliteSchema.position: tableModel.position,
        SettingsSqfliteSchema.address: tableModel.address,
      };
    } else {
      await _settingsSqfliteDao.deleteAll();
      mutableQueryRow = Map<String, dynamic>.of(immutableQueryRow);
      mutableQueryRow[SettingsSqfliteSchema.position] = tableModel.position;
      mutableQueryRow[SettingsSqfliteSchema.address] = tableModel.address;
    }
    return _settingsSqfliteDao.insert(settings: mutableQueryRow);
  }

  @override
  Future<bool> deleteDailyContent() => _daySqfliteDao.deleteAll();

  @override
  Future<bool> deleteHourlyContent() => _hourSqfliteDao.deleteAll();
}
