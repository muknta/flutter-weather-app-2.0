import 'package:flutter/material.dart';
import 'package:weather_app_2_0/data/api/rest_api/services/openweathermap_service.dart';
import 'package:weather_app_2_0/internal/services/internet_check.dart';

class IconFromNetwork extends StatelessWidget {
  const IconFromNetwork({Key? key, required String iconCode})
      : _iconCode = iconCode,
        super(key: key);

  final String _iconCode;

  @override
  Widget build(BuildContext context) {
    const Widget defaultWidget = SizedBox(height: 25.0);
    return FutureBuilder<bool>(
      future: isExistConnection(),
      builder: (context, imageSnap) => imageSnap.hasData
          ? imageSnap.data!
              ? Image.network(OpenWeatherMapService.getIconUrl(_iconCode))
              : defaultWidget
          : defaultWidget,
    );
  }
}
