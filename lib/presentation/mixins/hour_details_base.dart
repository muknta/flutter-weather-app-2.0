import 'package:flutter/material.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/data/storage/constants.dart';
import 'package:weather_app_2_0/domain/model/i_model.dart';
import 'package:weather_app_2_0/presentation/helpers/details_styles.dart';
import 'package:weather_app_2_0/presentation/mixins/i_details_base.dart';

class HourDetailsBase implements IDetailsBase {
  @override
  Widget getFieldValueBoxByTitle(IModel model, String title, String dayTimeFormatOfLang, String language) {
    final String doNotExistTable = localePhrases['data']['do_not_exist_table'][language];

    final value = _getFieldValueByTitle(model, title, dayTimeFormatOfLang);
    return value != null
        ? Text(
            '$value ${hourFieldsInfo[title]["unit"][language]}',
            style: fieldStyle,
          )
        : Text(
            doNotExistTable,
            style: fieldStyle,
          );
  }

  dynamic _getFieldValueByTitle(IModel model, String title, String dayTimeFormatOfLang) {
    final hour = model as Hour;
    switch (title) {
      case 'time':
        return toTimeOfDayStr(hour.time, dayTimeFormatOfLang);
      case 'weather_main':
        return hour.weatherMain;
      case 'weather_desc':
        return hour.weatherDesc;
      case 'temperature':
        return hour.temperature;
      case 'temp_feels_like':
        return hour.tempFeelsLike;
      case 'pressure':
        return hour.pressure;
      case 'humidity':
        return hour.humidity;
      case 'atmospheric_temp':
        return hour.atmosphericTemp;
      case 'clouds':
        return hour.clouds;
      case 'wind_speed':
        return hour.windSpeed;
      case 'wind_degrees':
        return hour.windDegrees;
      case 'snow':
        return hour.snow;
      case 'rain':
        return hour.rain;
      default:
        return null;
    }
  }
}
