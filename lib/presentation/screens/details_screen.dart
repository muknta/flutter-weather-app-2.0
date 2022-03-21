import 'package:easy_localization/easy_localization.dart' as easy_local;
import 'package:flutter/material.dart';
import 'package:weather_app_2_0/domain/model/i_model.dart';
import 'package:weather_app_2_0/presentation/utils/resources/details_styles.dart';
import 'package:weather_app_2_0/presentation/widgets/icon_from_network.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required IModel model,
    required String timeFormat,
    required List<String> parametersList,
  })  : _model = model,
        _timeFormat = timeFormat,
        _parametersList = parametersList,
        super(key: key);

  final IModel _model;
  final String _timeFormat;
  final List<String> _parametersList;

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
              IconFromNetwork(iconCode: _model.weatherIconCode),
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
                      title: Text(easy_local.tr(_title)),
                      trailing: _model.getFieldValueBoxByTitle(
                        _model,
                        _title,
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
