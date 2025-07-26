
import 'package:flutter/material.dart';
import '../models/rooms/rooms_list.dart';
import '../models/rooms/rooms_model.dart';
import '../widgets/device_card.dart';
import '../widgets/room_card.dart';

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {

  Room? selectedRoom;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: selectedRoom != null
            ? IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            setState(() {
              selectedRoom = null;
            });
          },
        )
            : null ,
        title: Text(selectedRoom == null ? 'Rooms' : selectedRoom!.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: selectedRoom == null ? RoomsGrid() : DevicesGrid(),
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
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        var room = rooms[index];
        return RoomCard(
          img: room.image,
          txt: room.name,
          device: '${room.devices.length} devices',
          ontap: () {
            setState(() {
              selectedRoom = room;
            });
          },
        );
      },
    );
  }

  Widget DevicesGrid() {
    var devices = selectedRoom!.devices;
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
