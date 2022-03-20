class Hour {
  const Hour({
    required this.time,
    required this.weatherMain,
    required this.weatherDesc,
    required this.weatherIconCode,
    required this.temperature,
    required this.tempFeelsLike,
    required this.pressure,
    required this.humidity,
    required this.atmosphericTemp,
    required this.clouds,
    required this.windSpeed,
    required this.windDegrees,
    this.snow,
    this.rain,
  });

  final DateTime time;
  final String weatherMain;
  final String weatherDesc;
  final String weatherIconCode;
  final num temperature;
  final num tempFeelsLike;
  final int pressure;
  final int humidity;
  final num atmosphericTemp;
  final int clouds;
  final num windSpeed;
  final int windDegrees;
  final num? snow;
  final num? rain;
}
