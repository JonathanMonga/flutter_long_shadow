import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:long_shadow_animation/hex.dart';
import 'package:long_shadow_animation/light.dart';
import 'package:long_shadow_animation/shadow_point.dart';

class Box {
  double halfSize;
  double x;
  double y;
  double r;
  double shadowLength;
  Color color;
  final math.Random random;
  Size size;
  List<String> colors = ["f5c156", "e6616b", "5cd3ad"];

  Box({this.random, this.size}) {
    halfSize = (math.Random().nextDouble() * 100) + 1;
    x = (math.Random().nextDouble() * size.width) + 1;
    y = (math.Random().nextDouble() * size.height) + 1;
    r = math.Random().nextDouble() * math.pi;
    shadowLength = 1000;
    color = Hex.intToColor(Hex.stringToInt(
        colors[(math.Random().nextDouble() * colors.length).floor()]));
  }

  List<Point<double>> getDots() {
    double full = (math.pi * 2) / 4;

    Point<double> p1 =
        Point<double>(x + halfSize * math.sin(r), y + halfSize * math.cos(r));
    Point<double> p2 = Point<double>(
        x + halfSize * math.sin(r + full), y + halfSize * math.cos(r + full));
    Point<double> p3 = Point<double>(x + halfSize * math.sin(r + full * 2),
        y + halfSize * math.cos(r + full * 2));
    Point<double> p4 = Point<double>(x + halfSize * math.sin(r + full * 3),
        y + halfSize * math.cos(r + full * 3));

    return [p1, p2, p3, p4];
  }

  void rotate() {
    var speed = (60 - halfSize) / 20;
    r += speed * 0.002;
    x += speed;
    y += speed;
  }

  void draw(Canvas canvas, Size size) {
    List<Point<double>> dots = getDots();

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    Path path = Path();

    path.moveTo(dots[0].x, dots[0].y);
    path.lineTo(dots[1].x, dots[1].y);
    path.lineTo(dots[2].x, dots[2].y);
    path.lineTo(dots[3].x, dots[3].y);

    canvas.drawPath(path, paint);

    if (y - halfSize > size.height) {
      y -= size.height + 100;
    }
    
    if (x - halfSize > size.width) {
      x -= size.width + 100;
    }
  }

  void drawShadow(Canvas canvas, Light light) {
    List<Point<double>> dots = getDots();
    List<double> angles = [];
    List<ShadowPoint> points = [];

    for (Point dot in dots) {
      double angle = math.atan2(light.y - dot.y, light.x - dot.x);
      var endX = dot.x + shadowLength * math.sin(-angle - math.pi / 2);
      var endY = dot.y + shadowLength * math.cos(-angle - math.pi / 2);
      angles.add(angle);
      points.add(
          ShadowPoint(endX: endX, endY: endY, startX: dot.x, startY: dot.y));
    }

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Hex.intToColor(Hex.stringToInt("2c343f"));
    Path path = Path();

    for (var i = points.length - 1; i >= 0; i--) {
      var n = i == 3 ? 0 : i + 1;

      path.moveTo(points[i].startX, points[i].startY);
      path.lineTo(points[n].startX, points[n].startY);
      path.lineTo(points[n].endX, points[n].endY);
      path.lineTo(points[i].endX, points[i].endY);

      canvas.drawPath(path, paint);
    }
  }
}
