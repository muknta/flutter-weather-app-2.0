import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:easy_localization/easy_localization.dart' as easy_local;
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/data/storage/constants.dart';
import 'package:weather_app_2_0/domain/model/i_model.dart';
import 'package:weather_app_2_0/internal/services/locator.dart';
import 'package:weather_app_2_0/internal/services/navigation/navigation.dart';
import 'package:weather_app_2_0/main.dart';
import 'package:weather_app_2_0/presentation/blocs/main_bloc/bloc.dart';
import 'package:weather_app_2_0/presentation/utils/resources/details_styles.dart';
import 'package:weather_app_2_0/presentation/utils/resources/localization/locales.dart';
import 'package:weather_app_2_0/presentation/utils/resources/theme.dart';
import 'package:weather_app_2_0/presentation/widgets/home/list_parameters_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this._title, {Key? key}) : super(key: key);

  final String _title;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String? _language;
  Widget? _apiContentWidget;
  late MainBloc mainBloc;

  @override
  void initState() {
    super.initState();
    _language = 'en';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context);
    // _locationWidget = _getLocationWidget();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<Locale>(
        stream: mainBloc.languageStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _whileLoading();
          }
          if (snapshot.data! != context.locale) {
            context.setLocale(snapshot.data!);
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
          padding: const EdgeInsets.all(16.0),
          child: _contentColumn(),
        ),
      );

  Widget _languageChooser() => DropdownButton<String>(
        value: _language,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.brown),
        underline: Container(
          height: 2,
          color: Colors.brown,
        ),
        onChanged: (String? chosenLang) {
          mainBloc.addEvent(ChangeLanguageEvent(chosenLanguageCode: chosenLang!));
        },
        items: supportedLangCodes
            .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 20),
                  ),
                ))
            .toList(),
      );

  Widget _contentColumn() => StreamBuilder<ContentState>(
        stream: mainBloc.contentStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data is LoadingContentState) {
            return _whileLoading();
          }
          final ContentState? contentState = snapshot.data;
          if (contentState is LoadedContentState) {
            if (contentState.content is List<Day>) {
              print('is daily');
              _showDaily(contentState.content as List<Day>);
            } else if (contentState.content is List<Hour>) {
              print('is hourly');
              _showHourly(contentState.content as List<Hour>);
            }
          }

          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // _locationWidget!,
                _getLocationWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        child: Text(easy_local.tr('daily')),
                        onPressed: () {
                          mainBloc.addEvent(const GetDailyEvent());
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        child: Text(easy_local.tr('hourly')),
                        onPressed: () {
                          mainBloc.addEvent(const GetHourlyEvent());
                        },
                      ),
                    ),
                  ],
                ),
                contentState is LoadingContentState
                    ? _whileLoading()
                    : _apiContentWidget ?? Text(easy_local.tr('data_is_coming')),
              ],
            ),
          );
        },
      );

  Widget _showDaily(List<Day> dayList) => dayList.isNotEmpty
      ? Column(
          children: _getDayPartWidgetList(dayList),
        )
      : Text(easy_local.tr('press_one_more_daily'));

  Widget _showHourly(List<Hour> hourList) => hourList.isNotEmpty
      ? Column(
          children: _getHourWidgetList(hourList),
        )
      : Text(easy_local.tr('press_one_more_hourly'));

  List<Widget> _getDayPartWidgetList(List<Day> dayList) {
    final List<Widget> _dayWidgetList = [_getHintDetailed()];

    for (final day in dayList) {
      final String timeFormat = easy_local.DateFormat(easy_local.tr('date_format')).format(day.time);
      _dayWidgetList.addAll([
        getIconFromNetwork(day.weatherIconCode),
        Text(
          '${easy_local.tr('time_field')} $timeFormat',
          style: titleStyle,
        ),
        _getDayPartWidget(day),
      ]);
    }
    return _dayWidgetList;
  }

  List<Widget> _getHourWidgetList(List<Hour> hourList) {
    final List<Widget> _hourWidgetList = [_getHintDetailed()];

    for (final hour in hourList) {
      final String timeFormat =
          easy_local.DateFormat('${easy_local.tr('day_time_format')}, ${easy_local.tr('date_format')}')
              .format(hour.time);
      _hourWidgetList.addAll([
        getIconFromNetwork(hour.weatherIconCode),
        Text(
          '${easy_local.tr('time_field')} $timeFormat',
          style: titleStyle,
        ),
        _getHourPartWidget(hour),
      ]);
    }
    return _hourWidgetList;
  }

  Widget _getDayPartWidget(Day day) {
    final List<String> _dayPartList = ['weather_description', 'day_temperature'];
    void onTap() {
      locator<NavigationService>().navigateTo(
        dayDetailsRoute,
        arguments: <String, dynamic>{
          dayDetailsRouteDayArg: day,
        },
      );
    }

    return ListParametersView(
      model: day,
      parametersList: _dayPartList,
      onTap: onTap,
    );
  }

  Widget _getHourPartWidget(Hour hour) {
    final List<String> _hourPartList = ['weather_description', 'temperature'];
    void onTap() {
      locator<NavigationService>().navigateTo(
        hourDetailsRoute,
        arguments: <String, dynamic>{
          hourDetailsRouteHourArg: hour,
        },
      );
    }

    return ListParametersView(
      model: hour,
      parametersList: _hourPartList,
      onTap: onTap,
    );
  }

  Widget _getHintDetailed() => Text(
        easy_local.tr('press_detailed'),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          // fontSize: 15,
        ),
      );

  Widget _whileLoading() => const Center(
        child: CircularProgressIndicator(),
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
                      child: StreamBuilder<UpdatedGeoPositionState>(
                        stream: mainBloc.geoPositionStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return _whileLoading();
                          }
                          return GestureDetector(
                            onTap: () => mainBloc.addEvent(const UpdateGeoPositionEvent()),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _locationContent(
                                position: snapshot.data!.position,
                                address: snapshot.data!.address,
                              ),
                            ),
                          );
                        },
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

  List<Widget> _locationContent({required Position position, String? address}) {
    List<Widget> content = [
      Text(
        easy_local.tr('location'),
        style: Theme.of(context).textTheme.caption,
      ),
    ];
    // if (position == null) content.add(Text(easy_local.tr('location_update_position')));
    // content.add(Text(
    //   "${easy_local.tr('location_default_position')}: Lat: $_latitude, Long: $_longitude",
    //   style: Theme.of(context).textTheme.caption,
    // ));
    content = [
      content[0],
      Text(
        '${easy_local.tr('location_current_position')}: $position',
        style: Theme.of(context).textTheme.caption,
      ),
    ];
    if (address != null) {
      content.add(Text(
        '${easy_local.tr('location_current_address')}: $address',
        style: Theme.of(context).textTheme.bodyText2,
      ));
    }
    return content;
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
