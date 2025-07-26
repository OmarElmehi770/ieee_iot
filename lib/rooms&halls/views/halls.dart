
import 'package:flutter/material.dart';

import '../models/halls/halls_list.dart';
import '../models/halls/halls_model.dart';
import '../widgets/device_card.dart';
import '../widgets/room_card.dart';


class Halls extends StatefulWidget {
  const Halls({super.key});

  @override
  State<Halls> createState() => _HallsState();
}

class _HallsState extends State<Halls> {

  Hall? selectedHall;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: selectedHall != null
            ? IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            setState(() {
              selectedHall = null;
            });
          },
        )
            : null,
        title: Text(selectedHall == null ? 'Halls' : selectedHall!.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: selectedHall == null ? RoomsGrid() : DevicesGrid(),
    );
  }

  Widget RoomsGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: halls.length,
      itemBuilder: (context, index) {
        var room = halls[index];
        return RoomCard(
          img: room.image,
          txt: room.name,
          device: '${room.devices.length} devices',
          ontap: () {
            setState(() {
              selectedHall = room;
            });
          },
        );
      },
    );
  }

  Widget DevicesGrid() {
    var devices = selectedHall!.devices;
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        var device = devices[index];
        return DeviceCard(
          clr2:  device.isOn ? Colors.lightGreen : Colors.grey.shade200,
          clr: device.isOn ? Colors.red : Colors.grey,
          icon: device.icon,
          ontap: () {
            setState(() {

              device.isOn = !device.isOn;
            });
          },
          name: device.name,
          isOn: device.isOn,
          onChanged: (val) {
            setState(() {
              device.isOn = val;
            });
          },
        );
      },
    );
  }
}
