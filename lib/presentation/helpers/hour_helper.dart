import 'package:flutter/material.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/data/storage/constants.dart';

import 'list_helper.dart';

class HourHelper {
  static getHourFieldValueByTitle(Hour hour, String _title, String _dayTimeFormatOfLang) {
    switch (_title) {
      case 'time':
        return ListHelper.toTimeOfDayStr(hour.time, _dayTimeFormatOfLang);
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

  static getHourFieldValueBoxByTitle(Hour hour, String _title, String _dayTimeFormatOfLang, String _language) {
    final doNotExistLable = localePhrases['data']['do_not_exist_lable'][_language];

    final _value = getHourFieldValueByTitle(hour, _title, _dayTimeFormatOfLang);
    return _value != null
        ? Text(
            '$_value ${hourFieldsInfo[_title]["unit"][_language]}',
            style: ListHelper.fieldStyle(),
          )
        : Text(
            doNotExistLable,
            style: ListHelper.fieldStyle(),
          );
  }
}
