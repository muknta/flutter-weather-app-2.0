import 'package:flutter/material.dart';
import 'package:weather_app_2_0/domain/model/i_model.dart';
import 'package:weather_app_2_0/presentation/helpers/details_styles.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required IModel model,
    required String language,
    required String dayTimeFormatOfLang,
    required String timeFormat,
    required List<String> parametersList,
    required Map<String, dynamic> translatesMap,
  })  : _model = model,
        _language = language,
        _dayTimeFormatOfLang = dayTimeFormatOfLang,
        _timeFormat = timeFormat,
        _parametersList = parametersList,
        _translatesMap = translatesMap,
        super(key: key);

  final IModel _model;
  final String _language;
  final String _dayTimeFormatOfLang;
  final String _timeFormat;
  final List<String> _parametersList;
  final Map<String, dynamic> _translatesMap;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            _timeFormat,
            // style: titleStyle,
          ),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: <Widget>[
              getIconFromNetwork(_model.weatherIconCode),
              Container(
                padding: const EdgeInsets.all(10.0),
                // decoration: boxDecorList,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _parametersList.length - 1, // omitting 'time'
                  itemBuilder: (context, index) {
                    final String _title = _parametersList[index + 1];
                    return ListTile(
                      title: Text(_translatesMap[_title][_language]),
                      trailing: _model.getFieldValueBoxByTitle(
                        _model,
                        _title,
                        _dayTimeFormatOfLang,
                        _language,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
