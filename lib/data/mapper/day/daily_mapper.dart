import 'dart:convert';

import 'package:weather_app_2_0/data/api/model/day/api_day.dart';
import 'package:weather_app_2_0/data/api/model/day/day_table_model.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'day_mapper.dart';

class DailyMapper {
  static List<Day> fromApi(List<ApiDay> apiDayList) {
    final List<Day> dayList = [];

    for (final apiDay in apiDayList) {
      dayList.add(DayMapper.fromApi(apiDay));
    }
    return dayList;
  }

  static List<Day> fromTableModel(List<DayTableModel> dayTableModelList) {
    final dayList = <Day>[];

    for (final dayTableModel in dayTableModelList) {
      dayList.add(DayMapper.fromTableModel(dayTableModel));
    }
    return dayList;
  }

  static List<DayTableModel> toTableModel(List<Day> dayList) {
    final dayTableModelList = <DayTableModel>[];

    for (final day in dayList) {
      dayTableModelList.add(DayMapper.toTableModel(day));
    }
    return dayTableModelList;
  }

  static String encode(List<Day> daily) => jsonEncode(
        daily.map<Map<String, dynamic>>((day) => DayMapper.toMap(day)).toList(),
      );

  static List<Day> decode(String daily) =>
      (jsonDecode(daily) as List<dynamic>).map<Day>((item) => DayMapper.fromJson(item)).toList();
}
