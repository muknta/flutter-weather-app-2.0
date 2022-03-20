import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/domain/bloc/home_bloc.dart';
import 'package:weather_app_2_0/data/storage/constants.dart';

import 'helpers/day_helper.dart';
import 'helpers/hour_helper.dart';
import 'helpers/list_helper.dart';
import 'day_screen.dart';
import 'hour_screen.dart';

bool isTablet() {
  final Size size = window.physicalSize;
  final double ratio = window.devicePixelRatio;
  final double width = min(size.width / ratio, size.height / ratio);
  debugPrint(width.toString());
  return width > 600;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen(this._title, {Key? key}) : super(key: key);

  final String _title;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<String> _availableLangs = ['en', 'ru'];
  String? _language;
  String? _dayTimeFormatOfLang;
  String? _dateFormatOfLang;
  String? _hintDetailed;
  Geolocator? geolocator;
  Position? _currentPosition;
  String? _currentAddress;
  Widget? _locationWidget;
  double? _latitude;
  double? _longitude;
  bool? _isLoading;
  Widget? _apiContentWidget;

  List<Day>? _daily;
  List<Hour>? _hourly;
  HomeBloc? homeBloc;
  bool? dailyPressed;
  bool? hourlyPressed;

  @override
  void initState() {
    super.initState();
    if (!isTablet()) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    }
    _language = 'en';
    _latitude = 50.0;
    _longitude = 30.0;
    _isLoading = false;
    dailyPressed = false;
    hourlyPressed = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locationWidget = _getLocationWidget();
  }

  @override
  Widget build(BuildContext context) => Consumer<HomeBloc>(
        builder: (context, _homeBloc, child) {
          homeBloc = _homeBloc;

          return StreamBuilder<List<Day>>(
            stream: homeBloc?.dailyStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _daily = snapshot.data;
                if (dailyPressed ?? false) {
                  _apiContentWidget = _showDaily(_daily!);
                  debugPrint('showing daily stream');
                  dailyPressed = false;
                }
                debugPrint('hass Daily');
              } else {
                debugPrint('hass NOT Daily Dataa');
              }

              return StreamBuilder<List<Hour>?>(
                stream: homeBloc?.hourlyStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _hourly = snapshot.data;
                    if (hourlyPressed ?? false) {
                      _apiContentWidget = _showHourly(_hourly!);
                      debugPrint('showing hourly stream');
                      hourlyPressed = false;
                    }
                    debugPrint('hass Hourly');
                  } else {
                    debugPrint('hass NOT Hourly Dataa');
                  }

                  return StreamBuilder<String>(
                    stream: homeBloc?.languageStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        _language = snapshot.data;
                        _dateFormatOfLang = localePhrases['time']['date_format'][_language];
                        _dayTimeFormatOfLang = localePhrases['time']['day_time_format'][_language];
                        _hintDetailed = localePhrases['data']['press_detailed'][_language];
                        debugPrint('hass Language $_language');
                      } else {
                        debugPrint('hass NOT Language Dataa');
                      }

                      return StreamBuilder<List<double>>(
                        stream: homeBloc?.positionStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            _latitude = snapshot.data![0];
                            _longitude = snapshot.data![1];
                            _locationWidget = _getLocationWidget();
                            debugPrint('hass Position ${snapshot.data}');
                          } else {
                            debugPrint('hass NOT Hourly Dataa');
                          }

                          return StreamBuilder<bool>(
                            stream: homeBloc?.isLoadingStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _isLoading = snapshot.data;
                                debugPrint('hass isLoading ${snapshot.data}');
                              } else {
                                debugPrint('hass NOT isLoading Dataa');
                              }

                              return _futureBuilderLocation();
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      );

  Widget _futureBuilderLocation() => FutureBuilder<void>(
        future: _getCurrentLocation(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasError) {
            debugPrint('snapshot has error: $snapshot');
          }
          return _scaffold();
        },
      );

  Widget _scaffold() => Scaffold(
        appBar: AppBar(
          title: Text(widget._title),
          actions: <Widget>[
            _languageChooser(),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: _contentColumn(),
        ),
      );

  Widget _languageChooser() => DropdownButton<String>(
        value: _language,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.brown),
        underline: Container(
          height: 2,
          color: Colors.brown,
        ),
        onChanged: (String? chosenLang) {
          setState(() {
            _language = chosenLang;
          });
          homeBloc?.setLanguage.add(_language!);
        },
        items: _availableLangs.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 20),
            ),
          );
        }).toList(),
      );

  Widget _contentColumn() => SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _locationWidget!,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    child: Text(localePhrases['data']['daily'][_language]),
                    onPressed: () {
                      setState(() {
                        dailyPressed = true;
                      });
                      _daily = _getDaily();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    child: Text(localePhrases['data']['hourly'][_language]),
                    onPressed: () {
                      setState(() {
                        hourlyPressed = true;
                      });
                      _hourly = _getHourly();
                    },
                  ),
                ),
              ],
            ),
            _isLoading ?? true
                ? _whileLoading()
                : _apiContentWidget ?? Text(localePhrases['data']['data_is_coming'][_language]),
          ],
        ),
      );

  Widget _showDaily(List<Day> dayList) => dayList != null
      ? Column(
          children: _getDayPartWidgetList(dayList),
        )
      : Text(localePhrases['data']['press_one_more']['daily'][_language]);

  Widget _showHourly(List<Hour> hourList) => hourList != null
      ? Column(
          children: _getHourWidgetList(hourList),
        )
      : Text(localePhrases['data']['press_one_more']['hourly'][_language]);

  List<Widget> _getDayPartWidgetList(List<Day> dayList) {
    final List<Widget> _dayWidgetList = [_getHintDetailed()];

    for (final day in dayList) {
      _dayWidgetList.add(ListHelper.getIconFromNetwork(day.weatherIconCode));
      final String timeFormat = DateFormat(_dateFormatOfLang).format(day.time);
      _dayWidgetList.add(Text(
        '${dayFieldsInfo["time"][_language]} $timeFormat',
        style: ListHelper.titleStyle(),
      ));
      _dayWidgetList.add(_getDayPartWidget(day));
    }
    return _dayWidgetList;
  }

  List<Widget> _getHourWidgetList(List<Hour> hourList) {
    final List<Widget> _hourWidgetList = [_getHintDetailed()];

    for (final hour in hourList) {
      _hourWidgetList.add(ListHelper.getIconFromNetwork(hour.weatherIconCode));
      final String timeFormat = DateFormat("$_dayTimeFormatOfLang, $_dateFormatOfLang").format(hour.time);
      _hourWidgetList.add(Text(
        '${hourFieldsInfo["time"][_language]} $timeFormat',
        style: ListHelper.titleStyle(),
      ));
      _hourWidgetList.add(_getHourPartWidget(hour));
    }
    return _hourWidgetList;
  }

  Widget _getDayPartWidget(Day day) {
    final List<String> _dayPartList = ['weather_desc', 'day_temp'];

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: ListHelper.boxDecorList(),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _dayPartList.length,
        itemBuilder: (context, index) {
          final String _title = _dayPartList[index];
          return ListTile(
            title: Text(dayFieldsInfo[_title][_language]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DayScreen(
                    day: day,
                    language: _language!,
                    dayTimeFormatOfLang: _dayTimeFormatOfLang!,
                    dateFormatOfLang: _dateFormatOfLang!,
                  ),
                ),
              );
            },
            trailing: DayHelper.getDayFieldValueBoxByTitle(day, _title, _dayTimeFormatOfLang!, _language!),
          );
        },
      ),
    );
  }

  Widget _getHourPartWidget(Hour hour) {
    final List<String> _hourPartList = ['weather_desc', 'temperature'];

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: ListHelper.boxDecorList(),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _hourPartList.length,
        itemBuilder: (context, index) {
          final String _title = _hourPartList[index];
          return ListTile(
            title: Text(hourFieldsInfo[_title][_language]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HourScreen(
                    hour: hour,
                    language: _language!,
                    dayTimeFormatOfLang: _dayTimeFormatOfLang!,
                    dateFormatOfLang: _dateFormatOfLang!,
                  ),
                ),
              );
            },
            trailing: HourHelper.getHourFieldValueBoxByTitle(hour, _title, _dayTimeFormatOfLang!, _language!),
          );
        },
      ),
    );
  }

  Widget _getHintDetailed() => Text(
        _hintDetailed!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          // fontSize: 15,
        ),
      );

  Widget _whileLoading() => Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );

  Widget _getLocationWidget() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.location_on),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _locationContent(),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  List<Widget> _locationContent() {
    List<Widget> content = [
      Text(
        localePhrases['location'][_language],
        style: Theme.of(context).textTheme.caption,
      ),
    ];
    if (_currentPosition == null) content.add(Text(localePhrases['location']['update_position'][_language]));
    content.add(Text(
      "${localePhrases['location']['default_position'][_language]}: Lat: $_latitude, Long: $_longitude",
      style: Theme.of(context).textTheme.caption,
    ));
    if (_currentPosition != null) {
      content = [content[0]];
      content.add(Text(
        '${localePhrases['location']['current_position'][_language]}: $_currentPosition',
        style: Theme.of(context).textTheme.caption,
      ));
      if (_currentAddress != null) {
        content.add(Text(
          '${localePhrases['location']['current_address'][_language]}: $_currentAddress',
          style: Theme.of(context).textTheme.bodyText2,
        ));
      }
    }
    return content;
  }

  List<Day> _getDaily() {
    homeBloc?.updateDaily.add({
      'latitude': _latitude!,
      'longitude': _longitude!,
    });
    debugPrint('home.dart: daily: $_daily');
    return _daily!;
  }

  List<Hour>? _getHourly() {
    homeBloc?.updateHourly.add({
      'latitude': _latitude!,
      'longitude': _longitude!,
    });
    debugPrint('home.dart: hourly: $_hourly');
    return _hourly;
  }

  Future<void> _getCurrentLocation() async {
    // debugPrint('_getCurrentLocation111 IN');
    geolocator = await Geolocator();
    // ..forceAndroidLocationManager; TODO:
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      setState(() {
        _currentPosition = position;
        _latitude = _currentPosition?.latitude ?? 0.0;
        _longitude = _currentPosition?.longitude ?? 0.0;
        // debugPrint('_getCurrentLocation222 position: $position setState OUT');
      });
      homeBloc?.setPosition.add([_latitude!, _longitude!]);
      // debugPrint('_getCurrentLocation333 setState After');
      _getAddressFromLatLng();
      // debugPrint('_getCurrentLocation444 geolocator OUT');
    }).catchError((e) {
      debugPrint(e.toString());
    });
    // debugPrint('_getCurrentLocation555 OUT');
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
