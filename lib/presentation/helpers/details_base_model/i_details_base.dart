import 'package:flutter/material.dart';
import 'package:weather_app_2_0/domain/model/i_model.dart';

abstract class IDetailsBase {
  const IDetailsBase();

  Widget getFieldValueBoxByTitle(IModel model, String title);
}
