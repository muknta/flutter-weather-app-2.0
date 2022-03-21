import 'package:flutter/material.dart';

const defaultLocale = Locale('en');

const supportedLangCodes = <String>['en', 'ru'];
List<Locale>? _supportedLocales;
List<Locale> get supportedLocales =>
    _supportedLocales ?? List<Locale>.generate(supportedLangCodes.length, (index) => Locale(supportedLangCodes[index]));
