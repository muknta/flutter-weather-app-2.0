import 'package:flutter/material.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/data/storage/constants.dart';
import 'package:weather_app_2_0/domain/model/i_model.dart';
import 'package:weather_app_2_0/presentation/helpers/details_styles.dart';
import 'package:weather_app_2_0/presentation/mixins/i_details_base.dart';

class DayDetailsBase implements IDetailsBase {
  @override
  Widget getFieldValueBoxByTitle(IModel model, String title, String dayTimeFormatOfLang, String language) {
    final doNotExistTable = localePhrases['data']['do_not_exist_table'][language];

    final _value = _getFieldValueByTitle(model, title, dayTimeFormatOfLang);
    return _value != null
        ? Text(
            '$_value ${dayFieldsInfo[title]["unit"][language]}',
            style: fieldStyle,
          )
        : Text(
            doNotExistTable,
            style: fieldStyle,
          );
  }

  dynamic _getFieldValueByTitle(IModel model, String title, String dayTimeFormatOfLang) {
    final day = model as Day;
    switch (title) {
      case 'time':
        return toTimeOfDayStr(day.time, dayTimeFormatOfLang);
      case 'sunrise':
        return toTimeOfDayStr(day.sunrise, dayTimeFormatOfLang);
      case 'sunset':
        return toTimeOfDayStr(day.sunset, dayTimeFormatOfLang);
      case 'weather_main':
        return day.weatherMain;
      case 'weather_desc':
        return day.weatherDesc;
      case 'day_temp':
        return day.dayTemp;
      case 'min_temp':
        return day.minTemp;
      case 'max_temp':
        return day.maxTemp;
      case 'night_temp':
        return day.nightTemp;
      case 'eve_temp':
        return day.eveTemp;
      case 'morn_temp':
        return day.mornTemp;
      case 'day_temp_feels_like':
        return day.dayTempFeelsLike;
      case 'night_temp_feels_like':
        return day.nightTempFeelsLike;
      case 'eve_temp_feels_like':
        return day.eveTempFeelsLike;
      case 'morn_temp_feels_like':
        return day.mornTempFeelsLike;
      case 'pressure':
        return day.pressure;
      case 'humidity':
        return day.humidity;
      case 'atmospheric_temp':
        return day.atmosphericTemp;
      case 'clouds':
        return day.clouds;
      case 'wind_speed':
        return day.windSpeed;
      case 'wind_degrees':
        return day.windDegrees;
      case 'snow':
        return day.snow;
      case 'rain':
        return day.rain;
      default:
        return null;
    }
  }
}
