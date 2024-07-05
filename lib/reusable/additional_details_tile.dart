import 'package:flutter/material.dart';

class AdditionalDetailsTile extends StatelessWidget {
  final String propertyTitle;
  final String propertyIcon;
  final String propertyValue;
  const AdditionalDetailsTile(
      {super.key,
      required this.propertyTitle,
      required this.propertyIcon,
      required this.propertyValue});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Resusable details tile
    return SizedBox(
      width: width / 3.3,
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          elevation: 0,
          color: Colors.blue.withOpacity(0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                propertyTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: MediaQuery.of(context).size.width / 45),
              ),
              Image.asset(
                propertyIcon,
                scale: 13,
              ),
              Text(
                propertyValue,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 50),
              ),
            ],
          )),
    );
  }
}
