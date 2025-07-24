import 'package:flutter/material.dart';
import 'base_bottom_sheet.dart';

class DismissibleBottomSheet extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final double topPosition;
  final double cornerRadius;

  const DismissibleBottomSheet({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    required this.topPosition,
    this.cornerRadius = 20.0,
  });

  static Future<void> show({
    required BuildContext context,
    required Widget child,
    required double width,
    required double height,
    required double topPosition,
    double cornerRadius = 20.0,
  }) async {
    return BaseBottomSheet.show(
      context: context,
      width: width,
      height: height,
      topPosition: topPosition,
      cornerRadius: cornerRadius,
      child: DismissibleBottomSheet(
        width: width,
        height: height,
        topPosition: topPosition,
        cornerRadius: cornerRadius,
        child: child,
      ),
    );
  }

  @override
  State<DismissibleBottomSheet> createState() => _DismissibleBottomSheetState();
}

class _DismissibleBottomSheetState extends State<DismissibleBottomSheet> {
  // Track vertical drag
  double _dragDistance = 0.0;

  // Threshold for dismissal
  final double _dismissThreshold = 100.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        setState(() {
          _dragDistance = 0.0;
        });
      },
      onVerticalDragUpdate: (details) {
        // Only allow downward dragging
        if (details.delta.dy > 0) {
          setState(() {
            _dragDistance += details.delta.dy;
          });
        }
      },
      onVerticalDragEnd: (details) {
        if (_dragDistance > _dismissThreshold) {
          // Dismiss the bottom sheet
          Navigator.of(context).pop();
        } else {
          // Reset the drag distance
          setState(() {
            _dragDistance = 0.0;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _dragDistance, 0),
        child: widget.child,
      ),
    );
  }
}
