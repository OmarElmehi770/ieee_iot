class LightState {
  bool isOn;
  double brightness; // 0.0 to 1.0

  LightState({this.isOn = false, this.brightness = 0.0});
}

class FanState {
  bool isOn;
  int speedLevel; // 1, 2, or 3
  int? timerDuration; // in minutes
  DateTime? timerEndTime;

  FanState({
    this.isOn = false,
    this.speedLevel = 1,
    this.timerDuration,
    this.timerEndTime,
  });

  void setTimer(int minutes) {
    timerDuration = minutes;
    timerEndTime = DateTime.now().add(Duration(minutes: minutes));
  }

  void clearTimer() {
    timerDuration = null;
    timerEndTime = null;
  }
}
