import 'package:injectable/injectable.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/helpers/const.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/schemas/settings_sqflite_schema.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/sqflite_database.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton()
class SettingsSqfliteDao {
  Future<Database> get _db async => await SqfliteDatabase.instance.database;

  Future<bool> insert({required Map<String, dynamic> settings}) async {
    print('INSERT settings $settings');
    return await (await _db).insert(
          SettingsSqfliteSchema.tableName,
          settings,
        ) !=
        unsuccessfulReturnValueSqflite;
  }

  Future<bool> deleteAll() async =>
      await (await _db).delete(SettingsSqfliteSchema.tableName) != unsuccessfulReturnValueSqflite;

  Future<Map<String, dynamic>?> getColumnFieldByName({required String fieldName}) async {
    final resultList = (await (await _db).query(
      SettingsSqfliteSchema.tableName,
      columns: <String>[fieldName],
    ));
    if (resultList.isEmpty) {
      return null;
    }
    return resultList.first;
  }

  Future<Map<String, dynamic>?> getQueryRow() async {
    final resultList = (await (await _db).query(
      SettingsSqfliteSchema.tableName,
    ));
    if (resultList.isEmpty) {
      return null;
    }
    return resultList.first;
  }
}
