import 'package:flutter/material.dart';
import 'package:weatherapp/screens/weather_details_screen_tablet.dart';
import 'package:weatherapp/screens/weather_details_screen_mobile.dart';

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth > 700) {
        return const TabletScreen(); //Show tablet UI screen when the screen width is more than 700 pixels
      }
      return const WeatherDetailsScreen(); //Show mobile UI screen when the screen width is more than 700 pixels
    });
  }
}
