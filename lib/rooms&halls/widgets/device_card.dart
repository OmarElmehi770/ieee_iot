import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String name;
  final bool isOn;
  final ValueChanged<bool> onChanged;
  String icon ;
  Function() ontap;
  Color clr ;
  Color clr2 ;

   DeviceCard({
    super.key,
    required this.name,
    required this.isOn,
    required this.onChanged,
    required this.icon,
    required this.ontap,
     required this.clr,
     required this.clr2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap ,
      child: Container(
        width: 125,
        height: 100,
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Row(
               children: [
                 Image.asset(icon ,
                   width: 40,
                   height: 40,
                 ),
                 Spacer(),
                 Image.asset('assets/control_icons/dot.png' ,
                    color: clr2,
                   width: 5,
                   height: 5,
                 ),
               ],
             ),
              const SizedBox(height: 10),
              Text(name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Image.asset('assets/control_icons/power.png',
              width: 20,
                height: 20,
                color: clr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
