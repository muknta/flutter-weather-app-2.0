import 'package:flutter/material.dart';
import 'package:weather_app_2_0/internal/services/locator.dart';
import 'package:weather_app_2_0/internal/services/navigation/navigation.dart';
import 'package:weather_app_2_0/internal/resources/resources_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blue,
        body: _backgroundBody(context),
      );

  Widget _backgroundBody(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: _delayedImageNavigator(context),
            ),
          ],
        ),
      );

  Widget _delayedImageNavigator(BuildContext context) {
    bool tapped = false;
    Future.delayed(const Duration(milliseconds: 4000), () {
      if (!tapped) {
        locator<NavigationService>().navigateWithReplacementTo(homeRoute);
      }
    });
    return GestureDetector(
      onTap: () {
        tapped = true;
        locator<NavigationService>().navigateWithReplacementTo(homeRoute);
      },
      child: Image(
        image: const AssetImage(splashLogoPath),
        width: MediaQuery.of(context).size.width / 1.5,
      ),
    );
  }
}
