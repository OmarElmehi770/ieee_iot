class Device {
  String name;
  bool isOn;
  String icon ;

  Device({required this.name, required this.isOn , required this.icon });
}

class Hall {
  String name;
  String image;
  List<Device> devices;

  Hall({required this.name, required this.image, required this.devices});
}
