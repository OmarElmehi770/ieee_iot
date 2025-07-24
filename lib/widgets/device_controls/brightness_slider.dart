import 'package:flutter/material.dart';
import 'custom_slider_components.dart';

class BrightnessSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final bool isEnabled;
  final Color activeColor;
  final Color inactiveColor;
  final double width;
  final double height;

  const BrightnessSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.isEnabled = true,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.width = 321,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0%',
                style: TextStyle(
                  color: isEnabled ? Colors.grey[600] : Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              Text(
                '100%',
                style: TextStyle(
                  color: isEnabled ? Colors.grey[600] : Colors.grey[400],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: height,
            activeTrackColor: isEnabled ? activeColor : Colors.grey[400],
            inactiveTrackColor: Colors.grey[300],
            thumbColor: isEnabled ? activeColor : Colors.grey[400],
            overlayColor: activeColor.withAlpha(51), // ~0.2 opacity
            trackShape: const RoundedRectangleSliderTrackShape(),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
          ),
          child: Slider(value: value, onChanged: isEnabled ? onChanged : null),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            '${(value * 100).toInt()}%',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isEnabled ? activeColor : Colors.grey[400],
            ),
          ),
        ),
      ],
    );
  }
}
