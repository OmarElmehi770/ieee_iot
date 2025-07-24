import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FanSpeedSelector extends StatelessWidget {
  final int selectedSpeed;
  final Function(int) onSpeedChanged;
  final bool isEnabled;
  final Animation<double> rotationAnimation;

  const FanSpeedSelector({
    super.key,
    required this.selectedSpeed,
    required this.onSpeedChanged,
    required this.isEnabled,
    required this.rotationAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFanSpeedOption(context, 1),
        _buildFanSpeedOption(context, 2),
        _buildFanSpeedOption(context, 3),
      ],
    );
  }

  Widget _buildFanSpeedOption(BuildContext context, int speed) {
    final isSelected = selectedSpeed == speed;

    return Column(
      children: [
        // Fan icon with rotation animation
        SizedBox(
          width: 53.33,
          height: 56,
          child: AnimatedBuilder(
            animation: rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: rotationAnimation.value * 2 * 3.14159,
                child: Opacity(
                  opacity: isEnabled ? 1.0 : 0.5,
                  child: Icon(
                    Icons.air,
                    size: 40,
                    color: isSelected && isEnabled ? Colors.blue : Colors.black,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // Speed indicator text
        Text(
          speed.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected && isEnabled ? Colors.blue : Colors.grey[600],
          ),
        ),

        const SizedBox(height: 10),

        // Selection circle
        GestureDetector(
          onTap: isEnabled ? () => _handleSpeedSelection(speed) : null,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected && isEnabled
                  ? const Color(0xFF0207FD)
                  : Colors.grey[300],
            ),
          ),
        ),
      ],
    );
  }

  void _handleSpeedSelection(int speed) {
    if (selectedSpeed != speed) {
      HapticFeedback.selectionClick();
      onSpeedChanged(speed);
    }
  }
}
