import 'package:flutter/material.dart';
import 'package:ieee_iot/home/Widgets1/smart_light.dart';
import 'package:ieee_iot/home/Widgets1/smart_tv/smart_t_v.dart';

import 'fan.dart';

class CustomDeviceContainer extends StatelessWidget {
  final String image;
  final String title;
  final int choice;
  const CustomDeviceContainer({
    Key? key,
    required this.image,
    required this.title,
    required this.choice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _openPopupMenu(context, choice);
        },
        child: Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white54,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, width: 70, height: 70),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _openPopupMenu(BuildContext context, int choice) {
  List<Widget> PopUpMenuItems = [SmartLight(), Fan(), SmartTV()];
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(20),
        height: 450,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: PopUpMenuItems[choice - 1],
      );
    },
  );
}
