import 'dart:convert';

import 'package:weather_app_2_0/data/api/model/hour/api_hour.dart';
import 'package:weather_app_2_0/data/api/model/hour/hour_table_model.dart';
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

  static List<Hour> fromTableModel(List<HourTableModel> hourTableModelList) {
    final hourList = <Hour>[];

    for (final hourTableModel in hourTableModelList) {
      hourList.add(HourMapper.fromTableModel(hourTableModel));
    }
    return hourList;
  }

  static List<HourTableModel> toTableModel(List<Hour> hourList) {
    final hourTableModelList = <HourTableModel>[];

    for (final hour in hourList) {
      hourTableModelList.add(HourMapper.toTableModel(hour));
    }
    return hourTableModelList;
  }

  static String encode(List<Hour> hourly) => jsonEncode(
        hourly.map<Map<String, dynamic>>((hour) => HourMapper.toMap(hour)).toList(),
      );

  static List<Hour> decode(String hourly) =>
      (jsonDecode(hourly) as List<dynamic>).map<Hour>((item) => HourMapper.fromJson(item)).toList();
}
