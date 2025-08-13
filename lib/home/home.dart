import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../garage/bluetooth_page.dart';
import '../garage/garage_screen.dart';
import '../garden/screens/home_screen.dart';
import '../rooms&halls/views/halls.dart';
import '../rooms&halls/views/rooms.dart';
import 'Widgets1/custom_container.dart';
import 'Widgets1/custom_device_container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool x = true;
  bool y = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Home", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
        actions: [Image.asset('assets/images/IEEE.png')],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Security',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          x = !x;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 100,
                        height: 50,
                        child: Icon(
                          x ? Icons.toggle_on : Icons.toggle_off,
                          size: 50,
                          color: x ? const Color(0xFF0207FD) : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Power Saving',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          y = !y;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 100,
                        height: 50,
                        child: Icon(
                          y ? Icons.toggle_on : Icons.toggle_off,
                          size: 50,
                          color: y ? const Color(0xFF0207FD) : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 520),
            ListTile(
              title: Text(
                'Back to connection',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.bluetooth_connected,
                size: 28,
                color: Colors.black,
                weight: 20,
              ),
              onTap: (){
                Navigator.pop(context);
                Navigator.pop(context);
                },
              //leading: Icon(Icons.arrow_back_ios_new),
            ),
          ],
        ),
      ),
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
                            Text(
                              "Cairo,20 May 2025",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.cloudy_snowing, color: Colors.blue),
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    Text("Rainy Day"),
                                    Text(
                                      "30°C",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("25%", style: TextStyle(color: Colors.blue)),
                          Text(
                            'indoor humidity',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text("29%", style: TextStyle(color: Colors.blue)),
                          Text(
                            'outdoor humidity',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Running Devices",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomDeviceContainer(
                        title: "Smart light",
                        image: 'assets/images/idea_colored.png',
                        choice: 1,
                      ),
                      CustomDeviceContainer(
                        title: "Fan",
                        image: 'assets/images/fan_colored.png',
                        choice: 2,
                      ),
                      CustomDeviceContainer(
                        title: "Smart TV",
                        image: 'assets/images/responsive_colored.png',
                        choice: 3,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Rooms()),
                    );
                  },
                  child: CustomContainer(
                    title1: 'Rooms',
                    title2: "3 Rooms",
                    image: 'assets/images/room1.jpg',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Halls()),
                    );
                  },
                  child: CustomContainer(
                    title1: 'Halls',
                    title2: "2 Halls",
                    image: 'assets/images/room2.jpg',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BluetoothPage()),
                    );
                  },
                  child: CustomContainer(
                    title1: 'Garage',
                    title2: "2 Cars",
                    image: 'assets/images/garage.jpg',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    );
                  },
                  child: CustomContainer(
                    title1: 'Garden',
                    title2: "",
                    image: 'assets/images/garden.jpg',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
