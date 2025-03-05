import 'package:flutter/material.dart';

class StaticHouseIcon extends StatelessWidget {
  final double size;
  final Color color;

  const StaticHouseIcon({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.home_outlined,
          size: size,
          color: color,
        ),
        Icon(
          Icons.home,
          size: size * 0.8,
          color: color.withAlpha((0.3 * 255).toInt()),
        ),
      ],
    );
  }
}
