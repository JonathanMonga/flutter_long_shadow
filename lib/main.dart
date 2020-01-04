import 'dart:math';

import 'package:flutter/material.dart';
import 'package:long_shadow_animation/box.dart';
import 'package:long_shadow_animation/drawn_gear_.dart';
import 'package:long_shadow_animation/light.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  List<Box> boxes = [];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(microseconds: 100),
      vsync: this,
    );
    // Add listener
    animationController.addListener(() {
      setState(() {});
    });

    // Repeat the animation
    animationController.repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    List.generate(20, (index) {
      boxes.add(Box(
          random: Random(),
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height)));
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                      radius: 2,
                      colors: [Colors.green[500], Colors.blue],
                      stops: [0.009, 0.9]),
                ),
              ),
              LongShadowAnimation(
                  light: Light(
                      x: MediaQuery.of(context).size.width / 2,
                      y: MediaQuery.of(context).size.height / 2),
                  boxes: boxes),
            ],
          ),
        ),
      ),
    );
  }
}
