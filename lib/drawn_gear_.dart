import 'dart:math' as math;

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:long_shadow_animation/box.dart';
import 'package:long_shadow_animation/light.dart';

class LongShadowAnimation extends StatelessWidget {
  const LongShadowAnimation({@required this.light, this.boxes});

  final Light light;
  final List<Box> boxes;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _LongShadowAnimationPainter(
              light: light, size: MediaQuery.of(context).size, boxes: boxes),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock hand.
class _LongShadowAnimationPainter extends CustomPainter {
  static const double BASE_SIZE = 320.0;
  static const double STROKE_WIDTH = 6.0;

  math.Random random = math.Random();

  Light light;
  List<Box> boxes;

  _LongShadowAnimationPainter({@required this.light, Size size, this.boxes});

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < boxes.length; i++) {
      boxes[i].rotate();
      boxes[i].drawShadow(canvas, light);
    }

    for (var i = 0; i < boxes.length; i++) {
      collisionDetection(i);
      boxes[i].draw(canvas, size);
    }
  }

  @override
  bool shouldRepaint(_LongShadowAnimationPainter oldDelegate) {
    return true;
  }

  void collisionDetection(int b) {
    for (var i = boxes.length - 1; i >= 0; i--) {
      if (i != b) {
        var dx =
            (boxes[b].x + boxes[b].halfSize) - (boxes[i].x + boxes[i].halfSize);
        var dy =
            (boxes[b].y + boxes[b].halfSize) - (boxes[i].y + boxes[i].halfSize);
        var d = math.sqrt(dx * dx + dy * dy);
        if (d < boxes[b].halfSize + boxes[i].halfSize) {
          boxes[b].halfSize =
              boxes[b].halfSize > 1 ? boxes[b].halfSize -= 1 : 1;
          boxes[i].halfSize =
              boxes[i].halfSize > 1 ? boxes[i].halfSize -= 1 : 1;
        }
      }
    }
  }
}
