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
    return SizedBox(
      height: 140,
      width: 120,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          elevation: 0,
          color: Colors.blue.withOpacity(0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                propertyTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              Image.asset(
                propertyIcon,
                scale: 13,
              ),
              Text(
                propertyValue,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}
