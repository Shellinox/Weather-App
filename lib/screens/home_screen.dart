import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/constants.dart';
import 'package:weatherapp/provider/weather_provider.dart';
import 'package:weatherapp/screens/weather_details_screen_mobile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cityController = TextEditingController();
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Weather",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent, //to make the appbar transparent
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
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
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      hintText: "Enter city name",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (cityController.text.toString().isEmpty) {
                      // validation for empty textfield
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter a city name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.all(16),
                          width: 400,
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                      return;
                    }
                    weatherProvider.storeCityName(
                        cityController.text.toLowerCase().trim());
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const WeatherDetailsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(410, 60),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Search",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
