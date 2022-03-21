import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app_2_0/data/api/rest_api/request/get_request_body.dart';
import 'package:weather_app_2_0/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:weather_app_2_0/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:weather_app_2_0/domain/use_cases/local_use_cases/get_daily_content.dart';
import 'package:weather_app_2_0/domain/use_cases/local_use_cases/get_hourly_content.dart';
import 'package:weather_app_2_0/domain/use_cases/local_use_cases/get_user_language.dart';
import 'package:weather_app_2_0/domain/use_cases/local_use_cases/set_daily_content.dart';
import 'package:weather_app_2_0/domain/use_cases/local_use_cases/set_hourly_content.dart';
import 'package:weather_app_2_0/domain/use_cases/local_use_cases/set_user_language.dart';
import 'package:weather_app_2_0/domain/use_cases/remote_use_cases/fetch_daily_content.dart';
import 'package:weather_app_2_0/domain/use_cases/remote_use_cases/fetch_hourly_content.dart';
import 'package:weather_app_2_0/internal/services/internet_check.dart';
import 'package:weather_app_2_0/presentation/utils/mixins/bloc_stream_mixin.dart';
import 'package:weather_app_2_0/presentation/utils/resources/global_constants.dart';
import 'package:weather_app_2_0/presentation/utils/resources/localization/locales.dart';

import 'main_event.dart';
import 'main_state.dart';

class MainBloc with BlocStreamMixin {
  MainBloc({
    required IRemoteRepository remoteRepository,
    required ILocalRepository localRepository,
  })  : _remoteRepository = remoteRepository,
        _localRepository = localRepository,
        _defaultLanguage = 'en',
        _defaultLatitude = 50.0,
        _defaultLongitude = 30.0 {
    _eventController.listen(_handleEvent);

    _geolocatorPlatform = GeolocatorPlatform.instance;
  }

  final IRemoteRepository _remoteRepository;
  final ILocalRepository _localRepository;

  final String _defaultLanguage;
  String? _language;

  final double _defaultLatitude;
  final double _defaultLongitude;
  late final GeolocatorPlatform _geolocatorPlatform;
  Position? _position;

  final _eventController = BehaviorSubject<MainEvent>();
  Function(MainEvent) get addEvent => sinkAdd(_eventController);

  final _contentController = BehaviorSubject<ContentState>();
  Stream<ContentState> get contentStream => _contentController.stream;
  SinkFunction<ContentState> get _updateContent => sinkAdd(_eventController);

  final _geoPositionController = BehaviorSubject<UpdatedGeoPositionState>();
  Stream<UpdatedGeoPositionState> get geoPositionStream => _geoPositionController.stream;
  SinkFunction<UpdatedGeoPositionState> get _updateGeoPosition => sinkAdd(_eventController);

  final _languageController = BehaviorSubject<Locale>();
  Stream<Locale> get languageStream => _languageController.stream;
  SinkFunction<Locale> get _setLanguage => sinkAdd(_languageController);

  Future<void> _handleEvent(dynamic event) async {
    if (event is MainEvent) {
      if (event is InitialEvent) {
        await _checkCurrentLocation();
        await _checkLanguage();
      } else if (event is GetDailyEvent) {
        await _getDaily(
            latitude: _position?.latitude ?? _defaultLatitude,
            longitude: _position?.longitude ?? _defaultLongitude,
            language: _language ?? _defaultLanguage);
      } else if (event is GetHourlyEvent) {
        await _getHourly(
            latitude: _position?.latitude ?? _defaultLatitude,
            longitude: _position?.longitude ?? _defaultLongitude,
            language: _language ?? _defaultLanguage);
      } else if (event is UpdateGeoPositionEvent) {
        await _checkCurrentLocation();
      } else if (event is ChangeLanguageEvent) {
        if (supportedLangCodes.contains(event.chosenLanguageCode)) {
          currentLanguage = event.chosenLanguageCode;
          _setLanguage(Locale(event.chosenLanguageCode));
          await SetUserLanguage(localRepository: _localRepository).execute(params: event.chosenLanguageCode);
        }
      }
    }
  }

  Future<void> _checkLanguage() async {
    String? userLanguage = await GetUserLanguage(localRepository: _localRepository).execute();
    if (userLanguage == null) {
      userLanguage = currentLanguage;
      await SetUserLanguage(localRepository: _localRepository).execute(params: userLanguage);
    } else {
      currentLanguage = userLanguage;
    }
    _setLanguage(Locale(userLanguage));
  }

  Future<void> _getDaily({
    required double latitude,
    required double longitude,
    required String language,
  }) async {
    _updateContent(const LoadingContentState());
    if (await isExistConnection()) {
      final data = await FetchDailyContent(remoteRepository: _remoteRepository).execute(
          params: GetRequestBody(
        latitude: latitude,
        longitude: longitude,
        language: language,
      ));
      if (data.isNotEmpty) {
        _updateContent(LoadedContentState(content: data));
        await SetDailyContent(localRepository: _localRepository).execute(params: data);
        return;
      }
    } else {
      final data = await GetDailyContent(localRepository: _localRepository).execute();
      if (data.isNotEmpty) {
        _updateContent(LoadedContentState(content: data));
        return;
      }
    }
    _updateContent(const NotLoadedContentState());
  }

  Future<void> _getHourly({
    required double latitude,
    required double longitude,
    required String language,
  }) async {
    _updateContent(const LoadingContentState());
    if (await isExistConnection()) {
      final data = await FetchHourlyContent(remoteRepository: _remoteRepository).execute(
          params: GetRequestBody(
        latitude: latitude,
        longitude: longitude,
        language: language,
      ));

      if (data.isNotEmpty) {
        _updateContent(LoadedContentState(content: data));
        await SetHourlyContent(localRepository: _localRepository).execute(params: data);
        return;
      }
    } else {
      final data = await GetHourlyContent(localRepository: _localRepository).execute();
      if (data.isNotEmpty) {
        _updateContent(LoadedContentState(content: data));
        return;
      }
    }
    _updateContent(const NotLoadedContentState());
  }

  Future<void> _checkCurrentLocation() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return;
    }
    await _updateCurrentLocation();
  }

  Future<void> _updateCurrentLocation() async {
    _position = await _geolocatorPlatform.getCurrentPosition();

    final String? address = await _getAddressFromLatLng(lat: _position!.latitude, lng: _position!.longitude);
    _updateGeoPosition(UpdatedGeoPositionState(
      position: _position!,
      address: address,
    ));
  }

  Future<bool> _handlePermission() async {
    // Test if location services are enabled.
    final bool serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    LocationPermission permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<String?> _getAddressFromLatLng({required double lat, required double lng}) async {
    try {
      final List<Placemark> placemarkList = await placemarkFromCoordinates(lat, lng);
      final Placemark place = placemarkList[0];

      return '${place.locality}, ${place.postalCode}, ${place.country}';
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  void dispose() {
    if (isStreamNotClosed(_eventController)) {
      _eventController.close();
    }
    if (isStreamNotClosed(_contentController)) {
      _contentController.close();
    }
    if (isStreamNotClosed(_geoPositionController)) {
      _geoPositionController.close();
    }
    if (isStreamNotClosed(_languageController)) {
      _languageController.close();
    }
  }
}
