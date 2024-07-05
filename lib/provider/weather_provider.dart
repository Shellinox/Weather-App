import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherProvider extends ChangeNotifier {
  String cityName = '';

  setCityName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    cityName = pref.getString("city") ?? ''; //setting the global cityName
  }

  storeCityName(String city) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("city",
        city); //Storing the name of the city in local storage for data persistence
  }
}
