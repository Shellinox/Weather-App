import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/provider/weather_provider.dart';
import 'package:weatherapp/screens/home_screen.dart';
import 'package:weatherapp/responsive/responsive_screen.dart';
import 'package:weatherapp/screens/weather_details_screen_mobile.dart';

String storedValue = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  final prefs = await SharedPreferences.getInstance();
  storedValue = prefs.getString('city') ?? '';
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => WeatherProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      home: storedValue == ''
          ? const HomeScreen() 
          : const ResponsiveScreen(), // Show details screen if stored value is not empty (For data persistance)
    );
  }
}
