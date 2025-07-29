import 'package:ieee_iot/rooms&halls/models/rooms/rooms_model.dart';

List< Room> rooms = [
  Room(
    name: ' Living Room',
    image: 'assets/images/living.png',
    devices: [
      Device(name: 'Smart Light 1', isOn: true, icon: 'assets/control_icons/smart_light.png'),
      Device(name: 'Smart Light 2', isOn: false , icon: 'assets/control_icons/smart_light.png'),
      Device(name: 'Fan', isOn: false , icon: 'assets/control_icons/fan.png'),
      Device(name: 'Smart TV', isOn: true , icon: 'assets/control_icons/tv.png'),
      Device(name: 'Window', isOn: false , icon: 'assets/control_icons/window.png'),
    ],
  ),
  Room(
    name: ' Bedroom 1',
    image: 'assets/images/bedroom.png',
    devices: [
      Device(name: 'Smart Light 1', isOn: true, icon: 'assets/control_icons/smart_light.png'),
      Device(name: 'Smart Light 2', isOn: false , icon: 'assets/control_icons/smart_light.png'),
      Device(name: 'Fan', isOn: false , icon: 'assets/control_icons/fan.png'),
      Device(name: 'Smart TV', isOn: true , icon: 'assets/control_icons/tv.png'),
      Device(name: 'Window', isOn: false , icon: 'assets/control_icons/window.png'),
    ],
  ),
  Room(
    name: ' Bedroom 2',
    image: 'assets/images/bedroom2.png',
    devices: [
      Device(name: 'Smart Light 1', isOn: true, icon: 'assets/control_icons/smart_light.png'),
      Device(name: 'Smart Light 2', isOn: false , icon: 'assets/control_icons/smart_light.png'),
      Device(name: 'Fan', isOn: false , icon: 'assets/control_icons/fan.png'),
      Device(name: 'Smart TV', isOn: true , icon: 'assets/control_icons/tv.png'),
      Device(name: 'Window', isOn: false , icon: 'assets/control_icons/window.png'),
    ],
  ),
];