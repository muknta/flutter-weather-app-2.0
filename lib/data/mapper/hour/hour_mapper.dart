import 'package:weather_app_2_0/data/api/model/hour/api_hour.dart';
import 'package:weather_app_2_0/data/api/model/hour/hour_table_model.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';

class HourMapper {
  static Hour fromApi(ApiHour hour) => Hour(
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
        snow: hour.snow,
        rain: hour.rain,
      );

  static Hour fromTableModel(HourTableModel hour) => Hour(
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
        snow: hour.snow,
        rain: hour.rain,
      );

  static HourTableModel toTableModel(Hour hour) => HourTableModel(
        time: hour.time.millisecondsSinceEpoch,
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
        snow: hour.snow,
        rain: hour.rain,
      );

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

  static Hour fromJson(Map<String, dynamic> jsonData) => Hour(
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
