import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/constants.dart';
import 'package:weatherapp/network/api_calls.dart';
import 'package:weatherapp/network/provider/weather_provider.dart';
import 'package:weatherapp/reusable/additional_details_tile.dart';
import 'package:weatherapp/screens/home_screen.dart';

class WeatherDetailsScreen extends StatefulWidget {
  final String city;
  const WeatherDetailsScreen({super.key, required this.city});

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    String city = Provider.of<WeatherProvider>(context).cityName;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                getCurrentWeather(city);
              });
            },
            icon: const Icon(Icons.refresh,color: Colors.black,),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(city),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.blue,));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          final data = snapshot.data!;
          final String city = data['name'];
          final String weatherType = data["weather"][0]["main"];
          final int temperature = (data['main']['temp'] - 273.15)
              .toInt(); //converting kelvin to celsius
          final int pressure = data['main']['pressure'];
          final int humidityPercentage = data['main']['humidity'];
          final double windSpeed = data['wind']["speed"];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          city.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Change",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  weatherIcons[weatherType]!,
                  scale: 3,
                ),
                Text(
                  "${temperature.toString()}°C",
                  style: GoogleFonts.manrope(
                      fontSize: 100, fontWeight: FontWeight.w900),
                ),
                Text(
                  weatherType.toString().toUpperCase(),
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Additional Information",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    AdditionalDetailsTile(
                      propertyTitle: 'Humidity',
                      propertyIcon: additionalWeatherIcons["Humidity"]!,
                      propertyValue: humidityPercentage.toString(),
                    ),
                    AdditionalDetailsTile(
                      propertyTitle: 'Pressure',
                      propertyIcon: additionalWeatherIcons["Pressure"]!,
                      propertyValue: pressure.toString(),
                    ),
                    AdditionalDetailsTile(
                      propertyTitle: 'Wind',
                      propertyIcon: additionalWeatherIcons["Wind"]!,
                      propertyValue: windSpeed.toString(),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
