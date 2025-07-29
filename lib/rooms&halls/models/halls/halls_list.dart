import 'halls_model.dart';

List< Hall> halls = [
  Hall(
    name: ' Main Hall',
    image: 'assets/images/hall.png',
    devices: [
      Device(name: 'Smart Light 1', isOn: true, icon: 'assets/control_icons/smart_light.png'),
      Device(name: 'Smart Light 2', isOn: false , icon: 'assets/control_icons/smart_light.png'),
      Device(name: 'Fan', isOn: false , icon: 'assets/control_icons/fan.png'),
      Device(name: 'Smart TV', isOn: true , icon: 'assets/control_icons/tv.png'),
      Device(name: 'Window', isOn: false , icon: 'assets/control_icons/window.png'),
    ],
  ),
  Hall(
    name: ' Hall 2',
    image: 'assets/images/bedroom.png',
    devices: [
      Device(name: 'Smart Light 1', isOn: true, icon: 'assets/control_icons/smart_light.png'),
      Device(name: 'Smart Light 2', isOn: false , icon: 'assets/control_icons/smart_light.png'),
      Device(name: 'Fan', isOn: false , icon: 'assets/control_icons/fan.png'),
      Device(name: 'Smart TV', isOn: true , icon: 'assets/control_icons/tv.png'),
      Device(name: 'Window', isOn: false , icon: 'assets/control_icons/window.png'),
    ],
  ),
];