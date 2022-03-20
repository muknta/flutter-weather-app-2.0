import 'package:flutter/material.dart';
import 'package:weather_app_2_0/internal/routes.dart';

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
    Future.delayed(Duration(milliseconds: 4000), () {
      if (!tapped) {
        _navigateTo(context, homeScreenRouteName);
      }
    });
    return GestureDetector(
      onTap: () {
        tapped = true;
        _navigateTo(context, homeScreenRouteName);
      },
      child: Image(
        image: AssetImage('assets/multi-logo.jpg'),
        width: MediaQuery.of(context).size.width / 1.5,
      ),
    );
  }

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
    Navigator.of(context).pop();
  }
}
