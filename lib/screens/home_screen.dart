import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/constants.dart';
import 'package:weatherapp/network/provider/weather_provider.dart';
import 'package:weatherapp/screens/weather_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cityController = TextEditingController();
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                weatherIcons["Clear"]!,
                scale: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Weather app",
                style: GoogleFonts.manrope(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  hintText: "Enter city name",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  weatherProvider
                      .setCity(cityController.text.toLowerCase().trim());
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => WeatherDetailsScreen(
                        city: weatherProvider.cityName,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Search",
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
