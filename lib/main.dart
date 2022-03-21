import 'package:easy_localization/easy_localization.dart' as easy_local;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app_2_0/internal/services/locator.dart';
import 'package:weather_app_2_0/presentation/utils/resources/localization/locales.dart';
import 'package:weather_app_2_0/presentation/utils/resources/resources_config.dart';
import 'package:weather_app_2_0/presentation/utils/resources/theme.dart';

import 'internal/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await easy_local.EasyLocalization.ensureInitialized();
  setupLocators();

  if (!isTablet()) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  runApp(easy_local.EasyLocalization(
    path: localesPath,
    fallbackLocale: defaultLocale,
    supportedLocales: supportedLocales,
    child: const Application(),
  ));
}
