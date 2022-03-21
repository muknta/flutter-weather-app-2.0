import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_2_0/data/storage/constants.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/presentation/screens/details_screen.dart';

class HourDetailsScreen extends StatelessWidget {
  const HourDetailsScreen({
    Key? key,
    required Hour hour,
    required String language,
    required String dayTimeFormatOfLang,
    required String dateFormatOfLang,
    required Map<String, dynamic> translatesMap,
  })  : _hour = hour,
        _language = language,
        _dayTimeFormatOfLang = dayTimeFormatOfLang,
        _dateFormatOfLang = dateFormatOfLang,
        _translatesMap = translatesMap,
        super(key: key);

  final Hour _hour;
  final String _language;
  final String _dayTimeFormatOfLang;
  final String _dateFormatOfLang;
  final Map<String, dynamic> _translatesMap;

  @override
  Widget build(BuildContext context) {
    final String timeFormat = DateFormat('$_dayTimeFormatOfLang, $_dateFormatOfLang').format(_hour.time);
    return DetailsScreen(
      model: _hour,
      language: _language,
      dayTimeFormatOfLang: _dayTimeFormatOfLang,
      timeFormat: timeFormat,
      parametersList: flatHourFields,
      translatesMap: _translatesMap,
    );
  }
}
