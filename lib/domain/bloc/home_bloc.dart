import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_app_2_0/domain/repository/day/daily_repository.dart';
import 'package:weather_app_2_0/domain/repository/hour/hourly_repository.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/data/mapper/day/daily_mapper.dart';
import 'package:weather_app_2_0/data/mapper/hour/hourly_mapper.dart';
import 'package:weather_app_2_0/internal/internet_check.dart';

class HomeBloc {
  HomeBloc(this._dailyRepository, this._hourlyRepository)
      : _defaultLanguage = 'en',
        _defaultPosition = [50.0, 30.0] {
    prefs = SharedPreferences.getInstance();
    prefs.then((val) {
      if (val.get('language') != null) {
        _language = val.getString('language') ?? _defaultLanguage;
      } else {
        _language = _defaultLanguage;
      }
      _languageActionController.stream.listen(_changeLanguage);
      _setLanguage.add(_language!);

      if (val.get('latitude') != null && val.get('longitude') != null) {
        _latitude = val.getDouble('latitude') ?? _defaultPosition[0];
        _longitude = val.getDouble('longitude') ?? _defaultPosition[1];
      } else {
        _latitude = _defaultPosition[0];
        _longitude = _defaultPosition[1];
      }
      _positionActionController.stream.listen(_changePosition);
      _setPosition.add([_latitude!, _longitude!]);

      if (val.get('hourly') != null) {
        final _hourlyStr = val.getString('hourly');
        if (_hourlyStr != null) {
          _hourly = HourlyMapper.decode(_hourlyStr);
          _updateHourly.add(_hourly!);
        }
      }
      _hourlyActionController.stream.listen(_getHourlyByCoords);

      if (val.get('daily') != null) {
        final _dailyStr = val.getString('daily');
        if (_dailyStr != null) {
          _daily = DailyMapper.decode(_dailyStr);
          _updateDaily.add(_daily!);
        }
      }
      _dailyActionController.stream.listen(_getDailyByCoords);
    });
  }

  final DailyRepository _dailyRepository;
  final HourlyRepository _hourlyRepository;
  late final String _defaultLanguage;

  /// [latitude, longitude]
  late final List<double> _defaultPosition;
  String? _language;
  double? _latitude;
  double? _longitude;
  List<Day>? _daily;
  List<Hour>? _hourly;
  late final Future<SharedPreferences> prefs;

  Day? day;
  Hour? hour;
  bool isLoading = false;

  /// Daily Api
  final StreamController<List<Day>> _dailyController = BehaviorSubject();
  Stream<List<Day>> get dailyStream => _dailyController.stream;
  Sink<List<Day>> get _updateDaily => _dailyController.sink;
  // void get resetDaily => _dailyActionController.sink.add(null);
  final StreamController<Map<String, double>> _dailyActionController = StreamController();
  StreamSink<Map<String, double>> get updateDaily => _dailyActionController.sink;

  /// Hourly Api
  final StreamController<List<Hour>?> _hourlyController = BehaviorSubject();
  Stream<List<Hour>?> get hourlyStream => _hourlyController.stream;
  Sink<List<Hour>?> get _updateHourly => _hourlyController.sink;
  final StreamController<Map<String, double>> _hourlyActionController = StreamController();
  StreamSink<Map<String, double>> get updateHourly => _hourlyActionController.sink;

  /// Language
  final BehaviorSubject<String> _languageController = BehaviorSubject();
  Stream<String> get languageStream => _languageController.stream;
  Sink<String> get _setLanguage => _languageController.sink;
  final StreamController<String> _languageActionController = StreamController();
  StreamSink<String> get setLanguage => _languageActionController.sink;

  /// Position(double latitude, double longitude)
  final BehaviorSubject<List<double>> _positionController = BehaviorSubject();
  Stream<List<double>> get positionStream => _positionController.stream;
  Sink<List<double>> get _setPosition => _positionController.sink;
  final StreamController<List<double>> _positionActionController = StreamController();
  StreamSink<List<double>> get setPosition => _positionActionController.sink;

  /// isLoading
  final BehaviorSubject<bool> _isLoadingController = BehaviorSubject();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;
  Sink<bool> get _setIsLoading => _isLoadingController.sink;

  void _getDailyByCoords(Map<String, double> coords) async {
    await _getDaily(
        latitude: coords['latitude'] ?? _defaultPosition[0],
        longitude: coords['longitude'] ?? _defaultPosition[1],
        language: _language ?? _defaultLanguage);
  }

  Future<void> _getDaily({
    required double latitude,
    required double longitude,
    required String language,
  }) async {
    _setIsLoading.add(true);
    if (await isExistConnection()) {
      debugPrint('connection exist');
      final data = await _dailyRepository.getDaily(
        latitude: latitude,
        longitude: longitude,
        language: language,
      );

      if (data != null) {
        debugPrint('daily data: $data with time ${data[0].time}');
        _daily = data;
        _updateDaily.add(data);
        prefs.then((val) {
          val.setString('daily', DailyMapper.encode(data));
        });
      }
    } else {
      debugPrint('connection does NOT exist');
      prefs.then((val) {
        final _dailyStr = val.getString('daily');
        _daily = DailyMapper.decode(_dailyStr ?? '');
        _updateHourly.add(null);
        _updateDaily.add(_daily!);
      });
    }
    _setIsLoading.add(false);
  }

  void _getHourlyByCoords(Map<String, double> coords) async {
    await _getHourly(
        latitude: coords['latitude'] ?? _defaultPosition[0],
        longitude: coords['longitude'] ?? _defaultPosition[1],
        language: _language ?? _defaultLanguage);
  }

  Future<void> _getHourly({
    required double latitude,
    required double longitude,
    required String language,
  }) async {
    _setIsLoading.add(true);
    if (await isExistConnection()) {
      debugPrint('connection exist');
      final data = await _hourlyRepository.getHourly(latitude: latitude, longitude: longitude, language: language);

      debugPrint('hourly data: $data');
      _hourly = data;
      _updateHourly.add(_hourly);
      prefs.then((val) {
        val.setString('hourly', HourlyMapper.encode(data));
      });
    } else {
      debugPrint('connection does NOT exist');
      prefs.then((val) {
        final _hourlyStr = val.getString('hourly');
        _hourly = HourlyMapper.decode(_hourlyStr ?? '');
        _updateHourly.add(null);
        _updateHourly.add(_hourly);
      });
    }
    _setIsLoading.add(false);
  }

  void _changeLanguage(String chosenLang) async {
    _language = chosenLang ?? _defaultLanguage;

    _setLanguage.add(_language!);
    prefs.then((val) {
      val.setString('language', _language ?? _defaultLanguage);
    });
  }

  void _changePosition(List<double> receivedPosition) async {
    _latitude = receivedPosition[0] ?? _defaultPosition[0];
    _longitude = receivedPosition[1] ?? _defaultPosition[1];

    _setPosition.add(receivedPosition);
    prefs.then((val) {
      val
        ..setDouble('latitude', _latitude!)
        ..setDouble('longitude', _longitude!);
    });
  }

  void dispose() {
    debugPrint('HomeBloc dispose');
    _dailyController.close();
    _dailyActionController.close();
    _hourlyController.close();
    _hourlyActionController.close();
    _languageController.close();
    _languageActionController.close();
    _positionController.close();
    _positionActionController.close();
    _isLoadingController.close();
  }
}
