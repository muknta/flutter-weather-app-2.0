import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_2_0/data/api/rest_api/services/openweathermap_service.dart';

const TextStyle fieldStyle = TextStyle(
  fontSize: 15,
);

const TextStyle titleStyle = TextStyle(
  // height: 3,
  fontSize: 16,
  fontStyle: FontStyle.italic,
);

final BoxDecoration boxDecorList = BoxDecoration(
  border: Border.all(
    color: Colors.brown.shade500,
  ),
  borderRadius: const BorderRadius.all(Radius.circular(8)),
);

String toTimeOfDayStr(DateTime rawTime, String _dayTimeFormatOfLang) =>
    DateFormat(_dayTimeFormatOfLang).format(rawTime);

// TODO: move to repos
Widget getIconFromNetwork(String iconCode) => Image.network(OpenWeatherMapService.getIconUrl(iconCode));
