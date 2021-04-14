/*
 * Copyright (c) 2020 - 2021 : William Todt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';

class MagnifierPainter extends CustomPainter {
  const MagnifierPainter({required this.color, this.strokeWidth = 5});

  final double strokeWidth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    _drawCircle(canvas, size);
    _drawCrosshair(canvas, size);
  }

  void _drawCircle(Canvas canvas, Size size) {
    Paint paintObject = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;

    canvas.drawCircle(
        size.center(Offset(0, 0)), size.longestSide / 2, paintObject);
  }

  void _drawCrosshair(Canvas canvas, Size size) {
    Paint crossPaint = Paint()
      ..strokeWidth = strokeWidth / 2
      ..color = color;

    double crossSize = size.longestSide * 0.04;

    canvas.drawLine(size.center(Offset(-crossSize, -crossSize)),
        size.center(Offset(crossSize, crossSize)), crossPaint);

    canvas.drawLine(size.center(Offset(crossSize, -crossSize)),
        size.center(Offset(-crossSize, crossSize)), crossPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
