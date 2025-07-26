import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  String img ;
  String txt ;
  String device ;
  Function() ontap;
   RoomCard({super.key ,
     required this.img ,
     required this.txt ,
     required this.device,
      required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap ,
      child: Container(
        width: 125,
        height: 130,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
           Image.asset(img),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(txt,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(device,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
