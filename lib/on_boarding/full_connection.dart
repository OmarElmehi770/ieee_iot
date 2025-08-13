import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../home/home.dart';

class BluetoothConnectionScreen extends StatefulWidget {
  const BluetoothConnectionScreen({super.key});

  @override
  State<BluetoothConnectionScreen> createState() =>
      _BluetoothConnectionScreenState();
}

class _BluetoothConnectionScreenState
    extends State<BluetoothConnectionScreen> with SingleTickerProviderStateMixin {
  BluetoothConnection? connection;
  bool isConnected = false ;
  BluetoothDevice? selectedDevice;

  List<BluetoothDevice> bondedDevices = [];
  List<BluetoothDiscoveryResult> availableDevices = [];
  bool isDiscovering = false;

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    getBondedDevices();
    startDiscovery();
  }

  Future<void> getBondedDevices() async {
    bondedDevices = await FlutterBluetoothSerial.instance.getBondedDevices();
    setState(() {});
  }

  void startDiscovery() async {
    // لو فيه discovery شغال، نوقفه
    await FlutterBluetoothSerial.instance.cancelDiscovery();

    availableDevices.clear();
    setState(() {
      isDiscovering = true;
    });

    FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      final existingIndex = availableDevices.indexWhere(
              (element) => element.device.address == r.device.address);
      if (existingIndex >= 0) {
        availableDevices[existingIndex] = r;
      } else {
        availableDevices.add(r);
      }
      setState(() {});
    }).onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }


  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      connection = await BluetoothConnection.toAddress(device.address);
      setState(() {
        selectedDevice = device;
        isConnected = true;
      });
    } catch (e) {
      print("Error connecting: $e");
    }
  }

  void sendToArduino(String message) {
    if (connection != null && connection!.isConnected) {
      connection!.output.add(Uint8List.fromList(message.codeUnits));
    }
  }

  @override
  void dispose() {
    connection?.dispose();
    tabController.dispose();
    super.dispose();
  }

  Widget buildDeviceList({
    required List<dynamic> devices,
    required bool isAvailableList,
  }) {
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = isAvailableList
            ? (devices[index] as BluetoothDiscoveryResult).device
            : devices[index] as BluetoothDevice;

        return Card(
          child: ListTile(
            title: Text(device.name ?? "Unknown"),
            subtitle: Text(device.address),
            onTap: () => connectToDevice(device),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Connection"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              startDiscovery();
              getBondedDevices();
            },
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: "Available"),
            Tab(text: "Paired"),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isConnected ? Colors.green[50] : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text("Connection status",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  isConnected
                      ? "Connected to ${selectedDevice?.name}"
                      : "Disconnected",
                  style: TextStyle(
                    color: isConnected ? Colors.green : Colors.red,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                buildDeviceList(devices: availableDevices, isAvailableList: true),
                buildDeviceList(devices: bondedDevices, isAvailableList: false),
              ],
            ),
          ),
          if (isConnected)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[500],
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Home()),
                  );
                },
                child: const Text(
                  "Go To Control",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
