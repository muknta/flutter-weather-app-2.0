import 'package:flutter/material.dart';
import 'package:weather_app_2_0/internal/services/locator.dart';

import 'internal/application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocators();

  runApp(const Application());
}
