import 'dart:async';

import 'package:weather_app_2_0/data/api/db_api/sqflite_api/schemas/hour_sqflite_schema.dart';
import 'package:weather_app_2_0/data/api/db_api/sqflite_api/schemas/day_sqflite_schema.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabase {
  SqfliteDatabase._();

  static final _singleton = SqfliteDatabase._();

  static SqfliteDatabase get instance => _singleton;
  String? _fullDBPath;

  Database? _database;
  Future<Database> get database async => _database ??= await _openDatabase();

  Future<Database> _openDatabase() async => await openDatabase(
        _fullDBPath ??= await _getDBPath(),
        onCreate: (db, version) async {
          await db.execute(_sqlCodeCreateTableDays);
          await db.execute(_sqlCodeCreateTableHours);
        },
        version: 1,
      );

  final String _sqlCodeCreateTableDays = '''
        CREATE TABLE ${DaySqfliteSchema.tableName}(
          ${DaySqfliteSchema.time} INTEGER PRIMARY KEY,
          ${DaySqfliteSchema.sunrise} INTEGER,
          ${DaySqfliteSchema.sunset} INTEGER,
          ${DaySqfliteSchema.weatherMain} TEXT,
          ${DaySqfliteSchema.weatherDesc} TEXT,
          ${DaySqfliteSchema.weatherIconCode} VARCHAR(255),
          ${DaySqfliteSchema.dayTemp} NUMERIC,
          ${DaySqfliteSchema.minTemp} NUMERIC,
          ${DaySqfliteSchema.maxTemp} NUMERIC,
          ${DaySqfliteSchema.nightTemp} NUMERIC,
          ${DaySqfliteSchema.eveTemp} NUMERIC,
          ${DaySqfliteSchema.mornTemp} NUMERIC,
          ${DaySqfliteSchema.dayTempFeelsLike} NUMERIC,
          ${DaySqfliteSchema.nightTempFeelsLike} NUMERIC,
          ${DaySqfliteSchema.eveTempFeelsLike} NUMERIC,
          ${DaySqfliteSchema.mornTempFeelsLike} NUMERIC,
          ${DaySqfliteSchema.pressure} INTEGER,
          ${DaySqfliteSchema.humidity} INTEGER,
          ${DaySqfliteSchema.atmosphericTemp} NUMERIC,
          ${DaySqfliteSchema.clouds} INTEGER,
          ${DaySqfliteSchema.windSpeed} NUMERIC,
          ${DaySqfliteSchema.windDegrees} INTEGER,
          ${DaySqfliteSchema.snow} NUMERIC,
          ${DaySqfliteSchema.rain} NUMERIC,
        );
        ''';

  final String _sqlCodeCreateTableHours = '''
        CREATE TABLE ${HourSqfliteSchema.tableName}(
          ${HourSqfliteSchema.time} INTEGER PRIMARY KEY,
          ${HourSqfliteSchema.weatherMain} TEXT,
          ${HourSqfliteSchema.weatherDesc} TEXT,
          ${HourSqfliteSchema.weatherIconCode} VARCHAR(255),
          ${HourSqfliteSchema.temperature} NUMERIC,
          ${HourSqfliteSchema.tempFeelsLike} NUMERIC,
          ${HourSqfliteSchema.pressure} INTEGER,
          ${HourSqfliteSchema.humidity} INTEGER,
          ${HourSqfliteSchema.atmosphericTemp} NUMERIC,
          ${HourSqfliteSchema.clouds} INTEGER,
          ${HourSqfliteSchema.windSpeed} NUMERIC,
          ${HourSqfliteSchema.windDegrees} INTEGER,
          ${HourSqfliteSchema.snow} NUMERIC,
          ${HourSqfliteSchema.rain} NUMERIC,
        );
        ''';

  Future<void> _deleteDatabase() async {
    await deleteDatabase(_fullDBPath ??= await _getDBPath());
  }

  Future<String> _getDBPath() async {
    // final appDocumentDir = await getApplicationDocumentsDirectory();
    _fullDBPath =
        '/data/user/0/com.example.weather_app_2_0/app_flutter/sqflite.db'; //join(appDocumentDir.path, sqfliteDBName);
    return _fullDBPath!;
  }
}
