import 'package:flutter/material.dart';

class RoundedRectangleSliderTrackShape extends SliderTrackShape {
  const RoundedRectangleSliderTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 6;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    Offset? secondaryOffset,
  }) {
    if (sliderTheme.trackHeight == 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Determine the active track end position
    final double activeTrackEnd = thumbCenter.dx;

    // Create the active track segment
    final Rect activeTrackRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      activeTrackEnd,
      trackRect.bottom,
    );

    // Create the inactive track segment
    final Rect inactiveTrackRect = Rect.fromLTRB(
      activeTrackEnd,
      trackRect.top,
      trackRect.right,
      trackRect.bottom,
    );

    final Paint activePaint = Paint()
      ..color = sliderTheme.activeTrackColor ?? Colors.blue;

    final Paint inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor ?? Colors.grey.shade400;

    final double radius = trackRect.height / 2;

    // Paint the active track segment with rounded corners on the left side
    context.canvas.drawRRect(
      RRect.fromRectAndCorners(
        activeTrackRect,
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      ),
      activePaint,
    );

    // Paint the inactive track segment with rounded corners on the right side
    context.canvas.drawRRect(
      RRect.fromRectAndCorners(
        inactiveTrackRect,
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ),
      inactivePaint,
    );
  }
}
