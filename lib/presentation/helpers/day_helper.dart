import 'package:flutter/material.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/data/storage/constants.dart';

import 'list_helper.dart';


class DayHelper {
  static getDayFieldValueByTitle(Day day, String _title, String _dayTimeFormatOfLang) {
    switch(_title) {
      case 'time': 
        return ListHelper.toTimeOfDayStr(day.time, _dayTimeFormatOfLang);
      case 'sunrise': 
        return ListHelper.toTimeOfDayStr(day.sunrise, _dayTimeFormatOfLang);
      case 'sunset': 
        return ListHelper.toTimeOfDayStr(day.sunset, _dayTimeFormatOfLang);
      case 'weather_main': return day.weatherMain;
      case 'weather_desc': return day.weatherDesc;
      case 'day_temp': return day.dayTemp;
      case 'min_temp': return day.minTemp;
      case 'max_temp': return day.maxTemp;
      case 'night_temp': return day.nightTemp;
      case 'eve_temp': return day.eveTemp;
      case 'morn_temp': return day.mornTemp;
      case 'day_temp_feels_like': return day.dayTempFeelsLike;
      case 'night_temp_feels_like': return day.nightTempFeelsLike;
      case 'eve_temp_feels_like': return day.eveTempFeelsLike;
      case 'morn_temp_feels_like': return day.mornTempFeelsLike;
      case 'pressure': return day.pressure;
      case 'humidity': return day.humidity;
      case 'atmospheric_temp': return day.atmosphericTemp;
      case 'clouds': return day.clouds;
      case 'wind_speed': return day.windSpeed;
      case 'wind_degrees': return day.windDegrees;
      case 'snow': return day.snow;
      case 'rain': return day.rain;
      default: return null;
    }
  }

  static getDayFieldValueBoxByTitle(Day day, String _title, String _dayTimeFormatOfLang, String _language) {
    final doNotExistLable = localePhrases['data']['do_not_exist_lable'][_language];

    var _value = getDayFieldValueByTitle(day, _title, _dayTimeFormatOfLang);
    return _value != null
      ? Text('$_value ${dayFieldsInfo[_title]["unit"][_language]}',
          style: ListHelper.fieldStyle(),
        )
      : Text(doNotExistLable,
          style: ListHelper.fieldStyle(),
        );

  }
}