import 'package:flutter/material.dart';

import '../core/app_images/app_images.dart';

class CardItemImageWidget extends StatelessWidget {
   CardItemImageWidget({super.key,required this.image,required this.title,required this.number,required this.subtitle});
String image;
String title;
String number;
String subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffF9F9F9),),

      width: double.infinity,
      height: 170,
      child: Column(
        children: [
          Image.asset(image),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(

              children: [
                Text(title,style: TextStyle(fontSize: 14),),
                Spacer(),
                Column(

                  children: [
                    Text(number,style: TextStyle(fontSize: 16),),
                    Text(subtitle,style: TextStyle(fontSize: 12),)
                  ],)
              ],),
          ),
        ],
      ),
    );
  }
}
