import 'package:easy_localization/easy_localization.dart' as easy_local;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_2_0/data/storage/constants.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/presentation/screens/details_screen.dart';

class HourDetailsScreen extends StatelessWidget {
  const HourDetailsScreen({
    Key? key,
    required Hour hour,
  })  : _hour = hour,
        super(key: key);

  final Hour _hour;

  @override
  Widget build(BuildContext context) {
    final String timeFormat =
        DateFormat('${easy_local.tr('day_time_format')}, ${easy_local.tr('date_format')}').format(_hour.time);
    return DetailsScreen(
      model: _hour,
      timeFormat: timeFormat,
      parametersList: flatHourFields,
    );
  }
}
