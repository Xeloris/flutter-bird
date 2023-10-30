import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class BorderedRectangle extends PositionComponent {
  BorderedRectangle(double x, double y, double width, double height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  @override
  void render(Canvas canvas) {
    final paint = BasicPalette.white.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.0;
    canvas.drawRect(toRect(), paint);
  }
}
