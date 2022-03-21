import 'package:injectable/injectable.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/helpers/const.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/schemas/hour_sqflite_schema.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/sqflite_database.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton()
class HourSqfliteDao {
  Future<Database> get _db async => await SqfliteDatabase.instance.database;

  Future<List<bool>> insertAll({required List<Map<String, dynamic>> hours}) async {
    final listOfReturnedValues = <bool>[];
    for (final Map<String, dynamic> hour in hours) {
      listOfReturnedValues.add(await insert(hour: hour));
    }
    return listOfReturnedValues;
  }

  Future<bool> insert({required Map<String, dynamic> hour}) async =>
      await (await _db).insert(
        HourSqfliteSchema.tableName,
        hour,
      ) !=
      unsuccessfulReturnValueSqflite;

  Future<bool> deleteAll() async =>
      await (await _db).delete(HourSqfliteSchema.tableName) != unsuccessfulReturnValueSqflite;

  Future<List<Map<String, dynamic>>> getAllHours() async => (await _db).query(
        HourSqfliteSchema.tableName,
      );
}
