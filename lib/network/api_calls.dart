import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/network/confidential.dart';

//Getting the weather information
Future<Map<String, dynamic>> getCurrentWeather() async {
  try {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String cityName = pref.getString("city") ?? '';
    final res = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$openWeatherAPIKey"));
    final data = jsonDecode(res.body);
    if (res.statusCode != 200) {
      throw res.statusCode;
    }

    return data;
  } catch (error) {
    throw error.toString();
  }
}
