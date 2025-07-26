import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/device_state.dart';

class DeviceStateManager {
  static const String _lightStateKey = 'light_state';
  static const String _fanStateKey = 'fan_state';

  // Singleton instance
  static final DeviceStateManager _instance = DeviceStateManager._internal();

  factory DeviceStateManager() {
    return _instance;
  }

  DeviceStateManager._internal();

  // Save light state to shared preferences
  Future<void> saveLightState(LightState state) async {
    final prefs = await SharedPreferences.getInstance();
    final stateMap = {'isOn': state.isOn, 'brightness': state.brightness};
    await prefs.setString(_lightStateKey, jsonEncode(stateMap));
  }

  // Load light state from shared preferences
  Future<LightState> loadLightState() async {
    final prefs = await SharedPreferences.getInstance();
    final stateString = prefs.getString(_lightStateKey);

    if (stateString == null) {
      return LightState(); // Return default state if not found
    }

    try {
      final stateMap = jsonDecode(stateString) as Map<String, dynamic>;
      return LightState(
        isOn: stateMap['isOn'] as bool,
        brightness: stateMap['brightness'] as double,
      );
    } catch (e) {
      debugPrint('Error loading light state: $e');
      return LightState(); // Return default state on error
    }
  }

  // Save fan state to shared preferences
  Future<void> saveFanState(FanState state) async {
    final prefs = await SharedPreferences.getInstance();
    final stateMap = {
      'isOn': state.isOn,
      'speedLevel': state.speedLevel,
      'timerDuration': state.timerDuration,
      'timerEndTime': state.timerEndTime?.toIso8601String(),
    };
    await prefs.setString(_fanStateKey, jsonEncode(stateMap));
  }

  // Load fan state from shared preferences
  Future<FanState> loadFanState() async {
    final prefs = await SharedPreferences.getInstance();
    final stateString = prefs.getString(_fanStateKey);

    if (stateString == null) {
      return FanState(); // Return default state if not found
    }

    try {
      final stateMap = jsonDecode(stateString) as Map<String, dynamic>;
      return FanState(
        isOn: stateMap['isOn'] as bool,
        speedLevel: stateMap['speedLevel'] as int,
        timerDuration: stateMap['timerDuration'] as int?,
        timerEndTime: stateMap['timerEndTime'] != null
            ? DateTime.parse(stateMap['timerEndTime'] as String)
            : null,
      );
    } catch (e) {
      debugPrint('Error loading fan state: $e');
      return FanState(); // Return default state on error
    }
  }
}
