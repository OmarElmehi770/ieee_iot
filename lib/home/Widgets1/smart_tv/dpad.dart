import 'package:flutter/material.dart';

class DPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            color: const Color(0xFF0207FD),
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          top: 1,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_drop_up, color: Colors.white, size: 30),
          ),
        ),
        Positioned(
          bottom: 1,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_drop_down, color: Colors.white, size: 30),
          ),
        ),
        Positioned(
          left: 1,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_left, color: Colors.white, size: 30),
          ),
        ),
        Positioned(
          right: 1,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_right, color: Colors.white, size: 30),
          ),
        ),
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: Text(
                'OK',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: const Color(0xFF0207FD),
                    fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}