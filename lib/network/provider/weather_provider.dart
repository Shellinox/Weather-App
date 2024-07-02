import 'package:flutter/material.dart';

class WeatherProvider extends ChangeNotifier {
  String cityName = '';
  setCity(String city) {
    cityName = city;
    notifyListeners();
  }
}
