import 'package:flutter/material.dart';

import 'cars_card.dart';
import 'garage_card.dart';

class GarageScreen extends StatelessWidget {
  const GarageScreen({
    super.key,
    required this.carsNumber,
    required this.garageOpen,
    required this.sendData,
  });
  final int carsNumber;
  final bool garageOpen;
  final void Function(String) sendData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garage', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarsCard(carsNumber: carsNumber),
            SizedBox(height: 30),
            GarageCard(sendData: sendData, garageOpen: garageOpen),
          ],
        ),
      ),
    );
  }
}
