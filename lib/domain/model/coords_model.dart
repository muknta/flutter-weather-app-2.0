import 'package:geolocator/geolocator.dart';

class CoordsModel {
  const CoordsModel({required this.position, this.address});

  final Position position;
  final String? address;
}
