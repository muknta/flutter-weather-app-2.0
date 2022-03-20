import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app_2_0/presentation/splash_screen.dart';
import 'package:weather_app_2_0/presentation/home_screen.dart';
import 'package:weather_app_2_0/domain/bloc/home_bloc.dart';

import 'routes.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  static const _title = 'Weather Getter';

  @override
  Widget build(BuildContext context) => MultiProvider(
      providers: [
        Provider<HomeBloc>(
          create: (_) => HomeBloc(),
          dispose: (_, HomeBloc homeBloc) => homeBloc.dispose(),
        ),
      ],
      child: MaterialApp(
        title: _title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(_title),
        initialRoute: splashScreenRouteName,
        routes: {
          splashScreenRouteName: (context) => SplashScreen(),
          homeScreenRouteName: (context) => HomeScreen(_title),
        },
      ),
    );
}
