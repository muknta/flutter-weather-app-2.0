import 'package:easy_localization/easy_localization.dart' as easy_local;
import 'package:flutter/material.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/i_model.dart';
import 'package:weather_app_2_0/presentation/utils/resources/details_styles.dart';
import 'package:weather_app_2_0/presentation/helpers/details_base_model/i_details_base.dart';

class DayDetailsBase implements IDetailsBase {
// TODO: break
  @override
  Widget getFieldValueBoxByTitle(IModel model, String title) {
    final _value = _getFieldValueByTitle(model, title);
    return _value != null
        ? Text(
            '$_value ${easy_local.tr("${title}_unit")}',
            style: fieldStyle,
          )
        : Text(
            easy_local.tr('do_not_exist_label'),
            style: fieldStyle,
          );
  }

  dynamic _getFieldValueByTitle(IModel model, String title) {
    final String dayTimeFormatOfLang = easy_local.tr('day_time_format');
    final day = model as Day;
    switch (title) {
      case 'time':
        return toTimeOfDayStr(day.time, dayTimeFormatOfLang);
      case 'sunrise':
        return toTimeOfDayStr(day.sunrise, dayTimeFormatOfLang);
      case 'sunset':
        return toTimeOfDayStr(day.sunset, dayTimeFormatOfLang);
      case 'weather_main_info':
        return day.weatherMain;
      case 'weather_description':
        return day.weatherDesc;
      case 'day_temperature':
        return day.dayTemp;
      case 'min_temperature':
        return day.minTemp;
      case 'max_temperature':
        return day.maxTemp;
      case 'night_temperature':
        return day.nightTemp;
      case 'evening_temperature':
        return day.eveTemp;
      case 'morning_temperature':
        return day.mornTemp;
      case 'day_temperature_feels_like':
        return day.dayTempFeelsLike;
      case 'night_temperature_feels_like':
        return day.nightTempFeelsLike;
      case 'evening_temperature_feels_like':
        return day.eveTempFeelsLike;
      case 'morning_temperature_feels_like':
        return day.mornTempFeelsLike;
      case 'pressure':
        return day.pressure;
      case 'humidity':
        return day.humidity;
      case 'atmospheric_temperature':
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
