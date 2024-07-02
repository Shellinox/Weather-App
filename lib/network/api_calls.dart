import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/network/confidential.dart';

Future<Map<String, dynamic>> getCurrentWeather(String city) async {
  try {
    String cityName = city;
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
