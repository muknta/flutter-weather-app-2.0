import 'package:weather_app_2_0/domain/model/i_model.dart';
import 'package:weather_app_2_0/presentation/mixins/day_details_base.dart';

class Day extends IModel with DayDetailsBase {
  const Day({
    required DateTime time,
    required this.sunrise,
    required this.sunset,
    required String weatherMain,
    required String weatherDesc,
    required String weatherIconCode,
    required this.dayTemp,
    required this.minTemp,
    required this.maxTemp,
    required this.nightTemp,
    required this.eveTemp,
    required this.mornTemp,
    required this.dayTempFeelsLike,
    required this.nightTempFeelsLike,
    required this.eveTempFeelsLike,
    required this.mornTempFeelsLike,
    required int pressure,
    required int humidity,
    required num atmosphericTemp,
    required int clouds,
    required num windSpeed,
    required int windDegrees,
    num? snow,
    num? rain,
  }) : super(
          time: time,
          weatherMain: weatherMain,
          weatherDesc: weatherDesc,
          weatherIconCode: weatherIconCode,
          pressure: pressure,
          humidity: humidity,
          atmosphericTemp: atmosphericTemp,
          clouds: clouds,
          windSpeed: windSpeed,
          windDegrees: windDegrees,
          snow: snow,
          rain: rain,
        );

  final DateTime sunrise;
  final DateTime sunset;
  final num dayTemp;
  final num minTemp;
  final num maxTemp;
  final num nightTemp;
  final num eveTemp;
  final num mornTemp;
  final num dayTempFeelsLike;
  final num nightTempFeelsLike;
  final num eveTempFeelsLike;
  final num mornTempFeelsLike;
}
