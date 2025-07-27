import 'package:flutter/material.dart';

class GarageCard extends StatefulWidget {
  GarageCard({super.key, required this.sendData, required this.garageOpen});
  final void Function(String) sendData;
  bool garageOpen;

  @override
  State<GarageCard> createState() => _GarageCardState();
}

class _GarageCardState extends State<GarageCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: 190,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.directions_car_outlined, size: 40),
                  SizedBox(height: 10),
                  Text('Garage', style: TextStyle(fontSize: 20)),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.garageOpen = !widget.garageOpen;
                      });
                      if (widget.garageOpen) {
                        widget.sendData('garage opened');
                      } else {
                        widget.sendData('garage closed');
                      }
                    },
                    icon: Icon(
                      Icons.power_settings_new,
                      size: 30,
                      color: widget.garageOpen ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),

              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.garageOpen ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
