import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:weather_app_2_0/data/api/model/coords_table_model.dart';
import 'package:weather_app_2_0/domain/model/coords_model.dart';

class CoordsModelMapper {
  static CoordsModel fromTableModel({required CoordsTableModel tableModel}) => CoordsModel(
        position: _positionFromString(encodedString: tableModel.position),
        address: tableModel.address,
      );

  static CoordsTableModel toTableModel({required CoordsModel model}) => CoordsTableModel(
        position: _positionToString(position: model.position),
        address: model.address,
      );

  static Position _positionFromString({required String encodedString}) => Position.fromMap(jsonDecode(encodedString));

  static String _positionToString({required Position position}) => jsonEncode(position.toJson());
}
