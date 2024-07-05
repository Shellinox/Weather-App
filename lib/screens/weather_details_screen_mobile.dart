import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/constants.dart';
import 'package:weatherapp/network/api_calls.dart';
import 'package:weatherapp/reusable/additional_details_tile.dart';
import 'package:weatherapp/screens/error_screen.dart';
import 'package:weatherapp/screens/home_screen.dart';

class WeatherDetailsScreen extends StatefulWidget {
  const WeatherDetailsScreen({super.key});

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                getCurrentWeather();
              });
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorScreen(
                errorCode: snapshot.error.toString(),
              ),
            );
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
                Image.asset(
                  weatherIcons[weatherType]!,
                  scale: 2,
                ),
                Text(
                  "${temperature.toString()}°C",
                  style: GoogleFonts.manrope(
                      fontSize: 90, fontWeight: FontWeight.w900),
                ),
                Text(
                  weatherType.toString().toUpperCase(),
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Additional Information",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height / 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      ),
                    )
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
