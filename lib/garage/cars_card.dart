import 'package:flutter/material.dart';

class CarsCard extends StatelessWidget {
  const CarsCard({super.key, required this.carsNumber});
  final int carsNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset('assets/images/car_garage.jpg'),
          ),

          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  'Total Cars',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text('$carsNumber Cars'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
