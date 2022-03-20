import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/data/storage/constants.dart';

import 'helpers/hour_helper.dart';
import 'helpers/list_helper.dart';

class HourScreen extends StatelessWidget {
  const HourScreen({
    Key? key,
    required this.hour,
    required this.language,
    required this.dayTimeFormatOfLang,
    required this.dateFormatOfLang,
  }) : super(key: key);

  final Hour hour;
  final String language;
  final String dayTimeFormatOfLang;
  final String dateFormatOfLang;

  @override
  Widget build(BuildContext context) {
    final String timeFormat = DateFormat("$dayTimeFormatOfLang, $dateFormatOfLang").format(hour.time);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$timeFormat',
          // style: ListHelper.titleStyle(),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: _getHourFullWidget(),
      ),
    );
  }

  Widget _getHourFullWidget() {
    return Column(
      children: <Widget>[
        ListHelper.getIconFromNetwork(hour.weatherIconCode),
        Container(
          padding: const EdgeInsets.all(10.0),
          // decoration: ListHelper.boxDecorList(),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: flatHourFields.length - 1, // omitting 'time'
            itemBuilder: (context, index) {
              String _title = flatHourFields[index + 1];
              return ListTile(
                title: Text(hourFieldsInfo[_title][language]),
                onTap: () {},
                trailing: HourHelper.getHourFieldValueBoxByTitle(hour, _title, dayTimeFormatOfLang, language),
              );
            },
          ),
        ),
      ],
    );
  }
}
