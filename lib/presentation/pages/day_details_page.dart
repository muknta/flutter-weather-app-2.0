import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_2_0/data/storage/constants.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/presentation/screens/details_screen.dart';

class DayDetailsScreen extends StatelessWidget {
  const DayDetailsScreen({
    Key? key,
    required Day day,
    required String language,
    required String dayTimeFormatOfLang,
    required String dateFormatOfLang,
    required Map<String, dynamic> translatesMap,
  })  : _day = day,
        _language = language,
        _dayTimeFormatOfLang = dayTimeFormatOfLang,
        _dateFormatOfLang = dateFormatOfLang,
        _translatesMap = translatesMap,
        super(key: key);

  final Day _day;
  final String _language;
  final String _dayTimeFormatOfLang;
  final String _dateFormatOfLang;
  final Map<String, dynamic> _translatesMap;

  @override
  Widget build(BuildContext context) {
    final String timeFormat = DateFormat(_dateFormatOfLang).format(_day.time);
    return DetailsScreen(
      model: _day,
      language: _language,
      dayTimeFormatOfLang: _dayTimeFormatOfLang,
      timeFormat: timeFormat,
      parametersList: flatDayFields,
      translatesMap: _translatesMap,
    );
  }
}
