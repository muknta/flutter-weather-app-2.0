import 'package:weather_app_2_0/domain/model/i_model.dart';
import 'package:weather_app_2_0/presentation/helpers/details_base_model/hour_details_base.dart';

class Hour extends IModel with HourDetailsBase {
  const Hour({
    required DateTime time,
    required String weatherMain,
    required String weatherDesc,
    required String weatherIconCode,
    required this.temperature,
    required this.tempFeelsLike,
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

  final num temperature;
  final num tempFeelsLike;
}
