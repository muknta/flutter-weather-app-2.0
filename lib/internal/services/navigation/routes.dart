import 'package:flutter/material.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/presentation/pages/day_details_page.dart';
import 'package:weather_app_2_0/presentation/pages/hour_details_page.dart';
import 'package:weather_app_2_0/presentation/screens/home_screen.dart';
import 'package:weather_app_2_0/presentation/screens/splash_screen.dart';

// Home screen
const String homeRoute = '/';
const String homeRouteTitleArg = 'title';
// Splash screen
const String splashRoute = '/splash';
// Details screen
const String hourDetailsRoute = '/details/hour';
const String hourDetailsRouteHourArg = 'hour';
const String dayDetailsRoute = '/details/day';
const String dayDetailsRouteDayArg = 'day';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      final arguments = settings.arguments as Map<String, dynamic>;
      final String title = arguments[homeRouteTitleArg];
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: HomeScreen(title),
      );
    case splashRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SplashScreen(),
      );
    case hourDetailsRoute:
      final arguments = settings.arguments as Map<String, dynamic>;
      final Hour hour = arguments[hourDetailsRouteHourArg];
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: HourDetailsScreen(
          hour: hour,
        ),
      );
    case dayDetailsRoute:
      final arguments = settings.arguments as Map<String, dynamic>;
      final Day day = arguments[dayDetailsRouteDayArg];
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: DayDetailsScreen(
          day: day,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}

PageRoute _getPageRoute({
  required String routeName,
  required Widget viewToShow,
}) =>
    MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow,
    );
