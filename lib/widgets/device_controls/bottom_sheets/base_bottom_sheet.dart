import 'package:flutter/material.dart';

class BaseBottomSheet extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final double topPosition;
  final double cornerRadius;

  const BaseBottomSheet({
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
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionAnimationController: AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: Navigator.of(context),
      ),
      builder: (context) => BaseBottomSheet(
        width: width,
        height: height,
        topPosition: topPosition,
        cornerRadius: cornerRadius,
        child: child,
      ),
    );
  }

  @override
  State<BaseBottomSheet> createState() => _BaseBottomSheetState();
}

class _BaseBottomSheetState extends State<BaseBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Start the animation when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          // Handle tap outside to dismiss
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Colors.transparent,
            child: GestureDetector(
              // Prevent taps inside the bottom sheet from dismissing
              onTap: () {},
              child: Stack(
                children: [
                  // The bottom sheet container
                  Positioned(
                    top:
                        widget.topPosition +
                        (_slideAnimation.value * screenHeight * 0.3),
                    left:
                        (MediaQuery.of(context).size.width - widget.width) / 2,
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Container(
                        width: widget.width,
                        height: widget.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(widget.cornerRadius),
                            topRight: Radius.circular(widget.cornerRadius),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, -2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Drag handle for bottom sheet
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            Expanded(child: widget.child),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
