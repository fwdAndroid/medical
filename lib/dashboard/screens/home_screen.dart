// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:medical/func/util.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   double _scale = 1.0;

//   void _zoomIn() {
//     setState(() {
//       _scale += 0.5; // Increase scale by 0.5
//     });
//   }

//   void _zoomOut() {
//     setState(() {
//       if (_scale > 1.0) {
//         _scale -=
//             0.5; // Decrease scale by 0.5, ensuring it doesn't go below 1.0
//       }
//     });
//   }

//   double _angle = 0.0;

//   void _rotateImage() {
//     setState(() {
//       _angle += 45.0; // Rotate by 45 degrees
//     });
//   }

//   double _brightness = 1.0;

//   void _increaseBrightness() {
//     setState(() {
//       if (_brightness < 1.0) {
//         _brightness += 0.1; // Increase brightness by 0.1
//       }
//     });
//   }

//   void _decreaseBrightness() {
//     setState(() {
//       if (_brightness > 0.0) {
//         _brightness -=
//             0.1; // Decrease brightness by 0.1, ensuring it doesn't go below 0.0
//       }
//     });
//   }

//   Uint8List? _imageData;

//   double _offset = 0.0;
//   AnimationController? _controller;

//   void _moveImage() {
//     if (_offset == 0) {
//       _controller!.forward();
//       setState(() {
//         _offset = 100.0; // Move by 100 pixels
//       });
//     } else {
//       _controller!.reverse();
//       setState(() {
//         _offset = 0.0; // Move back to the original position
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//           onPressed: _uploadImage,
//           child: Text(
//             "Save Result",
//             textAlign: TextAlign.center,
//           )),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Center(
//             child: GestureDetector(
//               onTap: () {
//                 _zoomIn();
//                 _rotateImage();
//               },
//               child: _imageData != null
//                   ? InteractiveViewer(
//                       scaleEnabled: true, // Enable zooming
//                       scaleFactor: _scale, // Set initial scale
//                       maxScale: 4.0, // Set maximum scale
//                       minScale: 1.0, // Set minimum scale
//                       child: Transform.rotate(
//                         angle: _angle *
//                             (3.141592653589793 /
//                                 180), // Convert degrees to radians
//                         child: ColorFiltered(
//                           colorFilter: ColorFilter.matrix([
//                             _brightness,
//                             0,
//                             0,
//                             0,
//                             0,
//                             0,
//                             _brightness,
//                             0,
//                             0,
//                             0,
//                             0,
//                             0,
//                             _brightness,
//                             0,
//                             0,
//                             0,
//                             0,
//                             0,
//                             1,
//                             0,
//                           ]),
//                           child: Image.memory(
//                             _imageData!,
//                             width: 300,
//                             height: 300,
//                           ),
//                         ),
//                       ))
//                   : Text("No Image Selected"),
//             ),
//           ),
//           SizedBox(height: 20),
//           Center(
//             child: GestureDetector(
//               onTap: _rotateImage,
//               child: InteractiveViewer(
//                 child: Image.asset(
//                   'assets/green.png',
//                   width: 70,
//                   height: 80,
//                 ),
//                 // Set minimum scale
//               ),
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () => selectImage(ImageSource.gallery),
//                 child: Text('Pick Image'),
//               ),
//               SizedBox(width: 20),
//               ElevatedButton(
//                 onPressed: _increaseBrightness,
//                 child: Text("Increase Brightness"),
//               ),
//               SizedBox(width: 20),
//               ElevatedButton(
//                 onPressed: _decreaseBrightness,
//                 child: Text("Decrease Brightness"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   //Functions
//   selectImage(ImageSource gallery) async {
//     Uint8List ui = await pickImage(ImageSource.gallery);
//     setState(() {
//       _imageData = ui;
//     });
//   }

//   Future<void> _uploadImage() async {
//     try {
//       FirebaseStorage storage = FirebaseStorage.instance;
//       Reference ref = storage.ref().child("images/image.jpg");
//       await ref.putData(_imageData!);
//       final String imageUrl = await ref.getDownloadURL();

//       // Store image path in Firestore
//       await FirebaseFirestore.instance.collection('images').add({
//         'imageUrl': imageUrl,
//         'brightness': _brightness,
//         'uid': FirebaseAuth.instance.currentUser!.uid,
//         "timeStamp": FieldValue.serverTimestamp()
//       });

//       print('Image uploaded successfully.');
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//   }
// }
