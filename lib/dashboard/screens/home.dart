import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _controller;
  double _currentSliderValue = 0.0;
  double _currentBrightnessSlider = 0.2; // Initial brightness
  double _currentContrastSlider = 1.0; // Initial contrast
  double _scale = 1.0; // Initial scale
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/series.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: _controller.value.isInitialized
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onScaleUpdate: (ScaleUpdateDetails details) {
                            setState(() {
                              _scale = details.scale;
                            });
                          },
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Transform.scale(
                              scale: _scale,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.matrix([
                                  _currentContrastSlider, 0, 0, 0,
                                  0, // Red channel
                                  0, _currentContrastSlider, 0, 0,
                                  0, // Green channel
                                  0, 0, _currentContrastSlider, 0,
                                  0, // Blue channel
                                  0, 0, 0, 1, 0, // Alpha channel
                                ]),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.matrix([
                                    1,
                                    0,
                                    0,
                                    0,
                                    _currentBrightnessSlider *
                                        255, // Red channel
                                    0,
                                    1,
                                    0,
                                    0,
                                    _currentBrightnessSlider *
                                        255, // Green channel
                                    0,
                                    0,
                                    1,
                                    0,
                                    _currentBrightnessSlider *
                                        255, // Blue channel
                                    0, 0, 0, 1, 0, // Alpha channel
                                  ]),
                                  child: VideoPlayer(_controller),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Slider(
                          value: _currentSliderValue,
                          min: 0,
                          max: _controller.value.duration.inSeconds.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                              _controller
                                  .seekTo(Duration(seconds: value.toInt()));
                            });
                          },
                          onChangeEnd: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.zoom_in, color: Colors.black),
                              onPressed: () {
                                setState(() {
                                  _scale += 0.1; // Increase scale
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.zoom_out, color: Colors.black),
                              onPressed: () {
                                setState(() {
                                  _scale -= 0.1; // Decrease scale
                                  if (_scale < 0.1) {
                                    _scale = 0.1;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        // Brightness Slider
                        Text("Brightness Slider"),
                        Slider(
                          value: _currentBrightnessSlider,
                          min: 0.0,
                          max:
                              1.0, // You can adjust the maximum brightness value
                          onChanged: (double value) {
                            setState(() {
                              _currentBrightnessSlider = value;
                            });
                          },
                          onChangeEnd: (double value) {
                            setState(() {
                              _currentBrightnessSlider = value;
                            });
                          },
                        ),
                        // Contrast Slider
                        Text("Contrast Slider"),
                        Slider(
                          value: _currentContrastSlider,
                          min: 0.0,
                          max: 2.0, // You can adjust the maximum contrast value
                          onChanged: (double value) {
                            setState(() {
                              _currentContrastSlider = value;
                            });
                          },
                          onChangeEnd: (double value) {
                            setState(() {
                              _currentContrastSlider = value;
                            });
                          },
                        ),
                      ],
                    )
                  : CircularProgressIndicator(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                  _isPlaying = false;
                } else {
                  _controller.play();
                  _isPlaying = true;
                }
              });
            },
            child: _isPlaying
                ? Text("Stop DCOM SIMULATION")
                : Text("Play DCOM SIMULATION"),
          ),
        ],
      ),
    );
  }
}
