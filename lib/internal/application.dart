import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_2_0/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:weather_app_2_0/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:weather_app_2_0/internal/services/locator.dart';
import 'package:weather_app_2_0/internal/services/navigation/navigation.dart';
import 'package:weather_app_2_0/presentation/blocs/main_bloc/bloc.dart';
import 'package:weather_app_2_0/presentation/screens/home_screen.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  static const _title = 'Weather Getter';

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<MainBloc>(
            create: (_) => MainBloc(
              remoteRepository: locator<IRemoteRepository>(),
              localRepository: locator<ILocalRepository>(),
            )..addEvent(const InitialEvent()),
            dispose: (_, MainBloc mainBloc) => mainBloc.dispose(),
          ),
        ],
        child: MaterialApp(
          title: _title,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: generateRoute,
          initialRoute: splashRoute,
          home: const HomeScreen(_title),
        ),
      );
}
