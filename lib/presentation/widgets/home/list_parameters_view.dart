import 'package:flutter/material.dart';
import 'package:weather_app_2_0/domain/model/i_model.dart';
import 'package:weather_app_2_0/presentation/helpers/details_styles.dart';

class ListParametersView extends StatelessWidget {
  const ListParametersView({
    Key? key,
    required IModel model,
    required List<String> parametersList,
    required String dayTimeFormatOfLang,
    required void Function() onTap,
    required Map<String, dynamic> translatesMap,
    required String language,
  })  : _model = model,
        _parametersList = parametersList,
        _dayTimeFormatOfLang = dayTimeFormatOfLang,
        _onTap = onTap,
        _language = language,
        _translatesMap = translatesMap,
        super(key: key);

  final IModel _model;
  final List<String> _parametersList;
  final String _dayTimeFormatOfLang;
  final void Function() _onTap;
  final Map<String, dynamic> _translatesMap;
  final String _language;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(10.0),
        decoration: boxDecorList,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _parametersList.length,
          itemBuilder: (context, index) {
            final String _title = _parametersList[index];
            return ListTile(
              title: Text(_translatesMap[_title][_language]),
              onTap: _onTap,
              trailing: _model.getFieldValueBoxByTitle(_model, _title, _dayTimeFormatOfLang, _language),
            );
          },
        ),
      );
}
