import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dismissible_bottom_sheet.dart';
import '../../../models/device_state.dart';
import '../../../utils/device_state_manager.dart';
import '../device_toggle_switch.dart';
import '../custom_fan_icon.dart';

class FanBottomSheet extends StatefulWidget {
  const FanBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Make bottom sheet full width like in the design
    final bottomSheetWidth = screenWidth;
    final bottomSheetHeight = screenHeight > 700 ? 507.0 : screenHeight * 0.7;
    final topPosition = screenHeight - bottomSheetHeight;

    return DismissibleBottomSheet.show(
      context: context,
      width: bottomSheetWidth,
      height: bottomSheetHeight,
      topPosition: topPosition,
      child: const FanBottomSheet(),
    );
  }

  @override
  State<FanBottomSheet> createState() => _FanBottomSheetState();
}

class _FanBottomSheetState extends State<FanBottomSheet>
    with SingleTickerProviderStateMixin {
  // Fan state
  late FanState _fanState;
  final DeviceStateManager _stateManager = DeviceStateManager();
  bool _isLoading = true;

  // Animation controller for fan rotation
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Load saved state
    _loadSavedState();
  }

  Future<void> _loadSavedState() async {
    _fanState = await _stateManager.loadFanState();

    // Initialize animation based on loaded state
    if (_fanState.isOn) {
      _startFanAnimation();
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

  void _toggleFan(bool value) {
    setState(() {
      _fanState.isOn = value;
      if (value) {
        _startFanAnimation();
      } else {
        _stopFanAnimation();
      }
    });

    // Save state
    _stateManager.saveFanState(_fanState);
  }

  void _setFanSpeed(int speed) {
    if (_fanState.speedLevel == speed) return;

    setState(() {
      _fanState.speedLevel = speed;
      if (_fanState.isOn) {
        _updateFanAnimationSpeed();
      }
    });

    // Add haptic feedback
    HapticFeedback.selectionClick();

    // Save state
    _stateManager.saveFanState(_fanState);
  }

  void _startFanAnimation() {
    _animationController.repeat();
    _updateFanAnimationSpeed();
  }

  void _stopFanAnimation() {
    _animationController.stop();
  }

  void _updateFanAnimationSpeed() {
    // Adjust animation speed based on fan speed level
    switch (_fanState.speedLevel) {
      case 1:
        _animationController.duration = const Duration(seconds: 3);
        break;
      case 2:
        _animationController.duration = const Duration(seconds: 2);
        break;
      case 3:
        _animationController.duration = const Duration(seconds: 1);
        break;
    }

    // Restart animation with new speed
    _animationController.stop();
    _animationController.repeat();
  }

  void _showTimerOptions() {
    final timerOptions = [
      {'label': '30 minutes', 'minutes': 30},
      {'label': '1 hour', 'minutes': 60},
      {'label': '2 hours', 'minutes': 120},
      {'label': '4 hours', 'minutes': 240},
    ];

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Set Timer'),
            content: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:
                    timerOptions
                        .map(
                          (option) => ListTile(
                            title: Text(option['label'] as String),
                            onTap: () {
                              setState(() {
                                _fanState.setTimer(option['minutes'] as int);
                              });
                              // Save state
                              _stateManager.saveFanState(_fanState);
                              Navigator.pop(context);
                            },
                          ),
                        )
                        .toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _fanState.clearTimer();
                  });
                  // Save state
                  _stateManager.saveFanState(_fanState);
                  Navigator.pop(context);
                },
                child: const Text('Clear Timer'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }

  Widget _buildFanSpeedOption(int speed) {
    final isEnabled = _fanState.isOn;

    return GestureDetector(
      onTap: isEnabled ? () => _setFanSpeed(speed) : null,
      child: Column(
        children: [
          // Fan icon with rotation animation and speed number
          SizedBox(
            width: 60,
            height: 60,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomFanIcon(
                  size: 45,
                  color: isEnabled ? Colors.black : Colors.grey[400]!,
                  animation: _animationController,
                ),
                // Speed number overlay
                Positioned(
                  bottom: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Text(
                      speed.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionCircle(int speed) {
    final isSelected = _fanState.speedLevel == speed;
    final isEnabled = _fanState.isOn;

    return GestureDetector(
      onTap: isEnabled ? () => _setFanSpeed(speed) : null,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              isSelected && isEnabled
                  ? const Color(0xFF0207FD)
                  : Colors.grey[300],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

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
                  'Fan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                DeviceToggleSwitch(
                  value: _fanState.isOn,
                  onChanged: _toggleFan,
                  activeColor: Colors.blue,
                  width: 40,
                  height: 40,
                ),
              ],
            ),

            SizedBox(height: isSmallScreen ? 20 : 30),

            // Fan Speed Options
            SizedBox(
              height: isSmallScreen ? 120 : 140,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Fan Icons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFanSpeedOption(1),
                        _buildFanSpeedOption(2),
                        _buildFanSpeedOption(3),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 15 : 20),
                    // Selection Circles Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSelectionCircle(1),
                        _buildSelectionCircle(2),
                        _buildSelectionCircle(3),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: isSmallScreen ? 15 : 20),

            // Timer Section - Centered
            SizedBox(
              height: isSmallScreen ? 100 : 120,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_fanState.timerDuration != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Timer: ${_fanState.timerDuration} minutes',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 12 : 14,
                          ),
                        ),
                      ),
                    // Timer button with circular background like in the design
                    Container(
                      width: isSmallScreen ? 60 : 80,
                      height: isSmallScreen ? 60 : 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(40),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: _fanState.isOn ? _showTimerOptions : null,
                          customBorder: const CircleBorder(),
                          child: Center(
                            child: Icon(
                              Icons.timer,
                              size: isSmallScreen ? 30 : 40,
                              color:
                                  _fanState.isOn
                                      ? Colors.grey[700]
                                      : Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Add some bottom padding for small screens
            if (isSmallScreen) const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
