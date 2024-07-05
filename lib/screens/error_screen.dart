import 'package:flutter/material.dart';
import 'package:weatherapp/constants.dart';
import 'package:weatherapp/screens/home_screen.dart';

class ErrorScreen extends StatelessWidget {
  final String errorCode;
  const ErrorScreen({super.key, required this.errorCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/error.png',
            scale: 5,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            textAlign: TextAlign.center,
            errorCodes[errorCode]!, //Showing custom error messages
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 50),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Go to Search",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
