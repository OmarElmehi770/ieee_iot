import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'garage_screen.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  BluetoothConnection? connection;
  String receivedData = '';
  int carsNumber = 0;
  bool garageOpen = true;

  @override
  void initState() {
    super.initState();
    connectToBluetooth();
  }

  void connectToBluetooth() async {
    BluetoothDevice? device;

    // Get list of paired devices
    List<BluetoothDevice> devices =
        await FlutterBluetoothSerial.instance.getBondedDevices();
    for (var d in devices) {
      if (d.name == "HC-05") {
        device = d;
        break;
      }
    }

    if (device != null) {
      connection = await BluetoothConnection.toAddress(device.address);
      // print('Connected to ${device.name}');

      connection!.input!.listen((data) {
        receivedData = String.fromCharCodes(data).trim();
        setState(() {
          if (receivedData == 'car entered') {
            carsNumber += 1;
          } else if (receivedData == 'car left') {
            carsNumber -= 1;
          }
        });
        // print('Received: $receivedData');
      });
    } else {
      // print('Device not found!');
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GarageScreen(

      sendData: sendToArduino, recieved: '',
    );
  }
}
