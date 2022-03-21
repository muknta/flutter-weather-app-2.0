// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayTableModel _$DayTableModelFromJson(Map<String, dynamic> json) =>
    DayTableModel(
      time: json['time'] as int,
      sunrise: json['sunrise'] as int,
      sunset: json['sunset'] as int,
      weatherMain: json['weatherMain'] as String,
      weatherDesc: json['weatherDesc'] as String,
      weatherIconCode: json['weatherIconCode'] as String,
      dayTemp: json['dayTemp'] as num,
      minTemp: json['minTemp'] as num,
      maxTemp: json['maxTemp'] as num,
      nightTemp: json['nightTemp'] as num,
      eveTemp: json['eveTemp'] as num,
      mornTemp: json['mornTemp'] as num,
      dayTempFeelsLike: json['dayTempFeelsLike'] as num,
      nightTempFeelsLike: json['nightTempFeelsLike'] as num,
      eveTempFeelsLike: json['eveTempFeelsLike'] as num,
      mornTempFeelsLike: json['mornTempFeelsLike'] as num,
      pressure: json['pressure'] as int,
      humidity: json['humidity'] as int,
      atmosphericTemp: json['atmosphericTemp'] as num,
      clouds: json['clouds'] as int,
      windSpeed: json['windSpeed'] as num,
      windDegrees: json['windDegrees'] as int,
      snow: json['snow'] as num?,
      rain: json['rain'] as num?,
    );

Map<String, dynamic> _$DayTableModelToJson(DayTableModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'weatherMain': instance.weatherMain,
      'weatherDesc': instance.weatherDesc,
      'weatherIconCode': instance.weatherIconCode,
      'dayTemp': instance.dayTemp,
      'minTemp': instance.minTemp,
      'maxTemp': instance.maxTemp,
      'nightTemp': instance.nightTemp,
      'eveTemp': instance.eveTemp,
      'mornTemp': instance.mornTemp,
      'dayTempFeelsLike': instance.dayTempFeelsLike,
      'nightTempFeelsLike': instance.nightTempFeelsLike,
      'eveTempFeelsLike': instance.eveTempFeelsLike,
      'mornTempFeelsLike': instance.mornTempFeelsLike,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'atmosphericTemp': instance.atmosphericTemp,
      'clouds': instance.clouds,
      'windSpeed': instance.windSpeed,
      'windDegrees': instance.windDegrees,
      'snow': instance.snow,
      'rain': instance.rain,
    };
