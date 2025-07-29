import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../home/home.dart';
import 'OnboardingScreens.dart.dart';

class Connectionscreen extends StatefulWidget {
  const Connectionscreen({super.key});

  @override
  State<Connectionscreen> createState() => _ConnectionscreenState();
}

class _ConnectionscreenState extends State<Connectionscreen> {
  bool isConnected = true;
  BluetoothDevice? connectedDevice;
  List<ScanResult> scanResults = [];

  @override
  void initState() {
    super.initState();
    requestPermissions().then((_) {
      startScan();
    });
  }

  Future<void> requestPermissions() async {
    final statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    if (statuses.values
        .any((status) => status.isDenied || status.isPermanentlyDenied)) {
      print("Permission denied.");
      return;
    }
  }

  void startScan() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      await FlutterBluePlus.stopScan();
      await device.connect();
      setState(() {
        isConnected = true;
        connectedDevice = device;
      });
    } catch (e) {
      print('Connection error: $e');
    }
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    connectedDevice?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isConnected ? Colors.green[50] : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                children: [
                  Text("Connection status",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(isConnected ? "Connected" : "Disconnected",
                      style: TextStyle(
                          color: isConnected ? Colors.green : Colors.red,
                          fontSize: 18))
                ],
              ),
            ),
          ),
          IconButton(onPressed: (){
            setState(() {
              isConnected = !isConnected;
            });
          }, icon: Icon(Icons.refresh)),
          Expanded(
            child: ListView.builder(
              itemCount: scanResults.length,
              itemBuilder: (context, index) {
                final result = scanResults[index];
                final device = result.device;

                return Card(
                  child: ListTile(
                    title:
                        Text(device.name.isNotEmpty ? device.name : 'Unknown'),
                    subtitle: Text(device.id.toString()),
                    trailing: Icon(Icons.settings),
                    onTap: () => connectToDevice(device),
                  ),
                );
              },
            ),
          ),
          if (isConnected)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[500],
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Home()));
                },
                child:
                    const Text("Go To Control", style: TextStyle(fontSize: 16,color: Colors.white)),
              ),
            ),
        ],
      ),

    );
  }
}
