import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  const Painter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width * 1.5;
    final offset = Offset(size.width + radius * 0.7, radius * 0.5);

    canvas.drawCircle(offset, radius, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Painter(color: Theme.of(context).colorScheme.primary),
      size: MediaQuery.of(context).size,
    );
  }
}
