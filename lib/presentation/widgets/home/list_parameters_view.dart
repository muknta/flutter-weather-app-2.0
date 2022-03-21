import 'package:easy_localization/easy_localization.dart' as easy_local;
import 'package:flutter/material.dart';
import 'package:weather_app_2_0/domain/model/i_model.dart';
import 'package:weather_app_2_0/presentation/utils/resources/details_styles.dart';

class ListParametersView extends StatelessWidget {
  const ListParametersView({
    Key? key,
    required IModel model,
    required List<String> parametersList,
    required void Function() onTap,
  })  : _model = model,
        _parametersList = parametersList,
        _onTap = onTap,
        super(key: key);

  final IModel _model;
  final List<String> _parametersList;
  final void Function() _onTap;

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
              title: Text(easy_local.tr(_title)),
              onTap: _onTap,
              trailing: _model.getFieldValueBoxByTitle(_model, _title),
            );
          },
        ),
      );
}
