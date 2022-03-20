import 'package:weather_app_2_0/data/api/model/hour/api_hour.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
// import 'package:weather_app_2_0/data/storage/constants.dart';

class HourMapper {
  static Hour fromApi(ApiHour hour) {
    return Hour(
      time: DateTime.fromMillisecondsSinceEpoch(hour.time.toInt() * 1000),
      weatherMain: hour.weatherMain,
      weatherDesc: hour.weatherDesc,
      weatherIconCode: hour.weatherIconCode,
      temperature: hour.temperature,
      tempFeelsLike: hour.tempFeelsLike,
      pressure: hour.pressure.toInt(),
      humidity: hour.humidity.toInt(),
      atmosphericTemp: hour.atmosphericTemp,
      clouds: hour.clouds.toInt(),
      windSpeed: hour.windSpeed,
      windDegrees: hour.windDegrees.toInt(),
      snow: hour.snow != null ? hour.snow! * 100 : null,
      rain: hour.rain != null ? hour.rain! * 100 : null,
    );
  }

  static Map<String, dynamic> toMap(Hour hour) => {
        'time': hour.time.millisecondsSinceEpoch,
        'weatherMain': hour.weatherMain,
        'weatherDesc': hour.weatherDesc,
        'weatherIconCode': hour.weatherIconCode,
        'temperature': hour.temperature,
        'tempFeelsLike': hour.tempFeelsLike,
        'pressure': hour.pressure,
        'humidity': hour.humidity,
        'atmosphericTemp': hour.atmosphericTemp,
        'clouds': hour.clouds,
        'windSpeed': hour.windSpeed,
        'windDegrees': hour.windDegrees,
        'snow': hour.snow,
        'rain': hour.rain,
      };

  static Hour fromJson(Map<String, dynamic> jsonData) {
    return Hour(
      time: DateTime.fromMillisecondsSinceEpoch(jsonData['time']),
      weatherMain: jsonData['weatherMain'],
      weatherDesc: jsonData['weatherDesc'],
      weatherIconCode: jsonData['weatherIconCode'],
      temperature: jsonData['temperature'],
      tempFeelsLike: jsonData['tempFeelsLike'],
      pressure: jsonData['pressure'],
      humidity: jsonData['humidity'],
      atmosphericTemp: jsonData['atmosphericTemp'],
      clouds: jsonData['clouds'],
      windSpeed: jsonData['windSpeed'],
      windDegrees: jsonData['windDegrees'],
      snow: jsonData['snow'],
      rain: jsonData['rain'],
    );
  }

  // Map<String, dynamic> toMap(Hour hour) => new Map.fromIterable(
  //     hourFields,
  //     key: (item) => item.toString(),
  //     value: (item) => hour.item
  //   );
}
