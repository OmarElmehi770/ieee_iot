import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double sliderValue = 50;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Icon(Icons.volume_down),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 12,
                elevation: 6,
                pressedElevation: 10,
              ),
            ),
            child: Expanded(
              child: Slider(
                inactiveColor: const Color(0xFF0207FD),
                activeColor: const Color(0xFF0207FD),
                thumbColor: Colors.white,
                value: sliderValue,
                min: 0,
                max: 100,
                label: sliderValue.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              ),
            ),
          ),
          Icon(Icons.volume_up)
        ],
      ),
    );
  }
}