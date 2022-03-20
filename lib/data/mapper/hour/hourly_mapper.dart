import 'dart:convert';

import 'package:weather_app_2_0/data/api/model/hour/api_hour.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'hour_mapper.dart';

class HourlyMapper {
  static List<Hour> fromApi(List<ApiHour> apiHourList) {
    final List<Hour> hourList = [];

    for (final apiHour in apiHourList) {
      hourList.add(HourMapper.fromApi(apiHour));
    }
    return hourList;
  }

  static String encode(List<Hour> hourly) => jsonEncode(
        hourly.map<Map<String, dynamic>>((hour) => HourMapper.toMap(hour)).toList(),
      );

  static List<Hour> decode(String hourly) =>
      (jsonDecode(hourly) as List<dynamic>).map<Hour>((item) => HourMapper.fromJson(item)).toList();
}
