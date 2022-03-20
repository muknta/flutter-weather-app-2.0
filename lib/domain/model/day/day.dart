class Day {
  const Day({
    required this.time,
    required this.sunrise,
    required this.sunset,
    required this.weatherMain,
    required this.weatherDesc,
    required this.weatherIconCode,
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
  final DateTime sunrise;
  final DateTime sunset;
  final String weatherMain;
  final String weatherDesc;
  final String weatherIconCode;
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
  final int pressure;
  final int humidity;
  final num atmosphericTemp;
  final int clouds;
  final num windSpeed;
  final int windDegrees;
  final num? snow;
  final num? rain;
}
