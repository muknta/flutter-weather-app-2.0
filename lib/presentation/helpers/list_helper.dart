import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_2_0/data/api/rest_api/services/openweathermap_service.dart';

class ListHelper {
  static TextStyle fieldStyle() => TextStyle(
        fontSize: 15,
      );

  static TextStyle titleStyle() => TextStyle(
        // height: 3,
        fontSize: 16,
        fontStyle: FontStyle.italic,
      );

  static BoxDecoration boxDecorList() {
    return BoxDecoration(
        border: Border.all(
          color: Colors.brown.shade500,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)));
  }

  static String toTimeOfDayStr(DateTime rawTime, String _dayTimeFormatOfLang) {
    return DateFormat(_dayTimeFormatOfLang).format(rawTime);
  }

  static Widget getIconFromNetwork(String iconCode) {
    return Image.network(OpenWeatherMapService.getIconUrl(iconCode));
  }
}
