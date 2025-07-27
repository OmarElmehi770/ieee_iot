
import 'package:flutter/material.dart';

class CardItemWidget extends StatefulWidget {
  final Icon icon;
  final Icon iconDown;
  final String title;

  const CardItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.iconDown,
  });

  @override
  State<CardItemWidget> createState() => _CardItemWidgetState();
}

class _CardItemWidgetState extends State<CardItemWidget> {
  bool isValue = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164,
      height: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffD9D9D9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget.icon,
                const Spacer(),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isValue ? const Color(0xff00FF1E) : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            IconButton(
              onPressed: () {
                setState(() {
                  isValue = !isValue;
                });
              },
              icon: Icon(
                Icons.power_settings_new,
                color: isValue ? const Color(0xff00FF1E) : Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}

