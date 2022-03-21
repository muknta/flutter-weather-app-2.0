import 'package:injectable/injectable.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/helpers/const.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/schemas/day_sqflite_schema.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/sqflite_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton()
class DaySqfliteDao {
  Future<Database> get _db => SqfliteDatabase.instance.database;

  Future<List<bool>> insertAll({required List<Map<String, dynamic>> days}) async {
    final listOfReturnedValues = <bool>[];
    for (final Map<String, dynamic> day in days) {
      listOfReturnedValues.add(await insert(day: day));
    }
    return listOfReturnedValues;
  }

  Future<bool> insert({required Map<String, dynamic> day}) async =>
      await (await _db).insert(
        DaySqfliteSchema.tableName,
        day,
      ) !=
      unsuccessfulReturnValueSqflite;

  Future<bool> deleteAll() async =>
      await (await _db).delete(DaySqfliteSchema.tableName) != unsuccessfulReturnValueSqflite;

  Future<List<Map<String, dynamic>>> getAllDays() async => (await _db).query(
        DaySqfliteSchema.tableName,
      );
}
