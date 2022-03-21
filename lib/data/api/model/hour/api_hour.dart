import 'package:flutter/foundation.dart';

class ApiHour {
  ApiHour.fromApi(Map<String, dynamic> map, int index)
      : time = map['hourly'][index]['dt'],
        weatherMain = map['hourly'][index]['weather'][0]['main'],
        weatherDesc = map['hourly'][index]['weather'][0]['description'],
        weatherIconCode = map['hourly'][index]['weather'][0]['icon'],
        temperature = map['hourly'][index]['temp'],
        tempFeelsLike = map['hourly'][index]['feels_like'],
        pressure = map['hourly'][index]['pressure'],
        humidity = map['hourly'][index]['humidity'],
        atmosphericTemp = map['hourly'][index]['dew_point'],
        clouds = map['hourly'][index]['clouds'],
        windSpeed = map['hourly'][index]['wind_speed'],
        windDegrees = map['hourly'][index]['wind_deg'],
        snow = map['hourly'][index].containsKey('snow') ? map['hourly'][index]['snow']['1h'] : null,
        rain = map['hourly'][index].containsKey('rain') ? map['hourly'][index]['rain']['1h'] : null {
    // debugPrint('ApiDay.fromApi: map: $map');
  }

  final num time;
  final String weatherMain; // [Rain, Snow, Extreme etc.]
  final String weatherDesc; // description
  final String weatherIconCode; // ex: 03d
  final num temperature; // [Celsius]
  final num tempFeelsLike; // [Celsius]
  final num pressure; // hPa
  final num humidity; // %
  final num atmosphericTemp; // dew_point, [Celsius]
  final num clouds; // Cloudiness, %
  final num windSpeed; // [metre/sec]
  final num windDegrees;
  final num? snow;
  final num? rain;

  // _getValueByKey(Map<String, dynamic> map, int index, String key) {
  //   return map['hourly'][index][key];
  // }
}
