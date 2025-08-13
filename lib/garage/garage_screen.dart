import 'package:flutter/material.dart';

import 'cars_card.dart';
import 'garage_card.dart';

class GarageScreen extends StatelessWidget {
  const GarageScreen({
    super.key,
    required this.recieved,
    required this.sendData,
  });
  final String recieved;
  final void Function(String data) sendData;

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
            CarsCard(carsNumber: 4),
            SizedBox(height: 30),
            GarageCard(sendData: sendData, garageOpen: true),
          ],
        ),
      ),
    );
  }
}
