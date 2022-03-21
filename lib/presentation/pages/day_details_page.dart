import 'package:easy_localization/easy_localization.dart' as easy_local;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_2_0/data/storage/constants.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/presentation/screens/details_screen.dart';

class DayDetailsScreen extends StatelessWidget {
  const DayDetailsScreen({
    Key? key,
    required Day day,
  })  : _day = day,
        super(key: key);

  final Day _day;

  @override
  Widget build(BuildContext context) {
    final String timeFormat = DateFormat(easy_local.tr('date_format')).format(_day.time);
    return DetailsScreen(
      model: _day,
      timeFormat: timeFormat,
      parametersList: flatDayFields,
    );
  }
}
