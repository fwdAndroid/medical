import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  double _angle = 0.0;

  void _rotateImage() {
    setState(() {
      _angle += 45.0; // Rotate by 45 degrees
    });
  }

  double _offset = 0.0;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void _moveImage() {
    if (_offset == 0) {
      _controller!.forward();
      setState(() {
        _offset = 100.0; // Move by 100 pixels
      });
    } else {
      _controller!.reverse();
      setState(() {
        _offset = 0.0; // Move back to the original position
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: GestureDetector(
              onTap: _rotateImage,
              child: Container(
                width: 200,
                height: 400,
                child: Transform.rotate(
                  angle: _angle *
                      (3.141592653589793 / 180), // Convert degrees to radians
                  child: Image.asset(
                      'assets/brain.png'), // Replace with your image
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: _rotateImage,
              child: Image.asset(
                "assets/green.png",
                width: 70,
                height: 80,
              ),
            ),
          )
        ],
      ),
    );
  }
}
