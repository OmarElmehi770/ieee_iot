import 'package:flutter/material.dart';
import 'dismissible_bottom_sheet.dart';
import '../../../models/device_state.dart';
import '../../../utils/device_state_manager.dart';
import '../brightness_slider.dart';
import '../device_toggle_switch.dart';

class SmartLightBottomSheet extends StatefulWidget {
  const SmartLightBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Make bottom sheet full width like in the design
    final bottomSheetWidth = screenWidth;
    final bottomSheetHeight = screenHeight > 600 ? 412.0 : screenHeight * 0.6;
    final topPosition = screenHeight - bottomSheetHeight;

    return DismissibleBottomSheet.show(
      context: context,
      width: bottomSheetWidth,
      height: bottomSheetHeight,
      topPosition: topPosition,
      child: const SmartLightBottomSheet(),
    );
  }

  @override
  State<SmartLightBottomSheet> createState() => _SmartLightBottomSheetState();
}

class _SmartLightBottomSheetState extends State<SmartLightBottomSheet>
    with SingleTickerProviderStateMixin {
  // Light state
  late LightState _lightState;
  final DeviceStateManager _stateManager = DeviceStateManager();
  bool _isLoading = true;

  // Animation controller for toggle effect
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _colorAnimation = ColorTween(
      begin: Colors.grey[300],
      end: Colors.blue[400],
    ).animate(_animationController);

    // Load saved state
    _loadSavedState();
  }

  Future<void> _loadSavedState() async {
    _lightState = await _stateManager.loadLightState();

    // Initialize animation based on loaded state
    if (_lightState.isOn) {
      _animationController.value = 1.0;
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleLight(bool value) {
    setState(() {
      _lightState.isOn = value;
      if (value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    // Save state
    _stateManager.saveLightState(_lightState);
  }

  void _updateBrightness(double value) {
    setState(() {
      _lightState.brightness = value;
    });

    // Save state
    _stateManager.saveLightState(_lightState);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 600;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with title and toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Smart Light',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                DeviceToggleSwitch(
                  value: _lightState.isOn,
                  onChanged: _toggleLight,
                  activeColor: Colors.blue,
                  width: 40,
                  height: 40,
                ),
              ],
            ),

            SizedBox(height: isSmallScreen ? 20 : 30),

            // Light Bulb Visualization
            Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Container(
                    width: isSmallScreen ? 60 : 80,
                    height: isSmallScreen ? 60 : 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _colorAnimation.value,
                      boxShadow:
                          _lightState.isOn
                              ? [
                                BoxShadow(
                                  color: Colors.blue.withAlpha(
                                    (76 + (_lightState.brightness * 127))
                                        .toInt(),
                                  ),
                                  blurRadius:
                                      20 + (_lightState.brightness * 30),
                                  spreadRadius:
                                      5 + (_lightState.brightness * 10),
                                ),
                              ]
                              : null,
                    ),
                    child: Icon(
                      Icons.lightbulb,
                      size: isSmallScreen ? 35 : 50,
                      color: _lightState.isOn ? Colors.white : Colors.grey[400],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: isSmallScreen ? 20 : 40),

            // Brightness Section
            Text(
              'Brightness',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: isSmallScreen ? 15 : 20),

            // Brightness Slider
            BrightnessSlider(
              value: _lightState.brightness,
              onChanged: _updateBrightness,
              isEnabled: _lightState.isOn,
              activeColor: Colors.blue,
              width: MediaQuery.of(context).size.width - 64, // Responsive width
              height: 6,
            ),

            // Add some bottom padding for small screens
            if (isSmallScreen) const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
