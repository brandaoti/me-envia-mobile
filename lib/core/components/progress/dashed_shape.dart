import 'package:flutter/material.dart';

import '../../values/values.dart';

enum DottedShapeType { dotted, line }

class DashedShape extends CustomPainter {
  final Color colorLine;
  final Color colorDotted;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpacing;
  final DottedShapeType shapeType;

  const DashedShape({
    this.dashWidth = 4.0,
    this.strokeWidth = 2.0,
    this.dashSpacing = 4.0,
    this.colorLine = AppColors.primary,
    this.colorDotted = AppColors.grey300,
    this.shapeType = DottedShapeType.dotted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final isDashed = shapeType == DottedShapeType.dotted;
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.square
      ..color = isDashed ? colorDotted : colorLine;

    if (isDashed) {
      _drawDashedLine(canvas, size, paint);
    } else {
      _drawStraightLine(canvas, size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawStraightLine(Canvas canvas, Size size, Paint paint) {
    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);
  }

  void _drawDashedLine(Canvas canvas, Size size, Paint paint) {
    // start line
    double startOffsetX = 0;

    // Loop to create line
    // using parent size
    while (startOffsetX < size.width) {
      canvas.drawLine(
        Offset(startOffsetX, 0),
        Offset(startOffsetX + dashWidth, 0),
        paint,
      );

      // Update the start OffsetX X
      startOffsetX += dashWidth + dashSpacing;
    }
  }
}
