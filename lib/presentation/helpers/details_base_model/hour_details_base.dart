import 'package:easy_localization/easy_localization.dart' as easy_local;
import 'package:flutter/material.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/domain/model/i_model.dart';
import 'package:weather_app_2_0/presentation/utils/resources/details_styles.dart';
import 'package:weather_app_2_0/presentation/helpers/details_base_model/i_details_base.dart';

class HourDetailsBase implements IDetailsBase {
// TODO: break
  @override
  Widget getFieldValueBoxByTitle(IModel model, String title) {
    final value = _getFieldValueByTitle(model, title);
    return value != null
        ? Text(
            ' $value ${easy_local.tr("${title}_unit")}',
            style: fieldStyle,
          )
        : Text(
            easy_local.tr('do_not_exist_label'),
            style: fieldStyle,
          );
  }

  dynamic _getFieldValueByTitle(IModel model, String title) {
    final String dayTimeFormatOfLang = easy_local.tr('day_time_format');
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
