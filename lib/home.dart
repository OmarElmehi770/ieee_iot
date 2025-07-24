import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Widgets1/custom_container.dart';
import 'Widgets1/custom_device_container.dart';
import 'Widgets1/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Home", style: TextStyle(fontSize: 16)),
        actions: [Image.asset('assets/images/IEEE.png')],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 106,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Cairo,20 May 2025", style: TextStyle(fontSize: 14,color: Colors.grey.shade600,)),
                            Row(
                              children: [
                                Icon(Icons.cloudy_snowing,color: Colors.blue,),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Text("Rainy Day"),
                                    Text("30°C",style: TextStyle(color: Colors.blue),)
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("25%",style: TextStyle(color: Colors.blue),),
                          Text('indoor humidity',style: TextStyle(fontSize: 12,color: Colors.grey.shade600,)),
                          Text("29%",style: TextStyle(color: Colors.blue),),
                          Text('outdoor humidity',style: TextStyle(fontSize: 12,color: Colors.grey.shade600,)),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Text("Running Devices",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomDeviceContainer(title: "Smart light", image: 'assets/images/idea_colored.png',choice: 1, ),
                      CustomDeviceContainer(title: "Fan", image: 'assets/images/fan_colored.png',choice: 2, ),
                      CustomDeviceContainer(title: "Smart TV", image: 'assets/images/responsive_colored.png',choice: 3,),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                CustomContainer(title1: 'Rooms',title2: "8 devices",  image: 'assets/images/room1.jpg', ),
                CustomContainer(title1: 'Halls',title2: "5 devices",  image: 'assets/images/room2.jpg', ),
                CustomContainer(title1: 'Garage',title2: "2 Cars",  image: 'assets/images/garage.jpg', ),
                CustomContainer(title1: 'Garden',title2: "",  image: 'assets/images/garden.jpg', ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
