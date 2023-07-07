import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:adv_camera/adv_camera.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/provider/ocrimage_provider.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late AdvCameraController _controller;
  FlashType flashType = FlashType.auto;
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ocrImageProvider = Provider.of<OCRImageProvider>(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex:9,
            child: AdvCamera(

              onCameraCreated: _onCameraCreated,
              onImageCaptured: (path) async {
                await ocrImageProvider.set(File(path));
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => DisplayPictureScreen(imageBytes: imageData),
                //   ),
                // );
              },
            ),
          ),
          Expanded(
              flex:1,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: flashIcon(),
                      onPressed: _toggleFlash,
                    ),
                    TextButton(
                      child: Icon(Icons.circle,size: 40,color: Colors.black),
                      onPressed: () {
                        _controller.captureImage();
                      },
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }

  void _onCameraCreated(AdvCameraController controller) {
    this._controller = controller;
  }
  _toggleFlash() {
    setState(() {
      switch (flashType) {
        case FlashType.auto:
          flashType = FlashType.on;
          break;
        case FlashType.on:
          flashType = FlashType.off;
          break;
        case FlashType.off:
          flashType = FlashType.auto;
          break;
        default:
          flashType = FlashType.auto;
      }
      _controller.setFlashType(flashType);
    });
  }

  Icon flashIcon() {
    switch (flashType) {
      case FlashType.auto:
        return Icon(Icons.flash_auto,size: 40,color: Colors.black,);
      case FlashType.on:
        return Icon(Icons.flash_on,size: 40,color: Colors.black,);
      case FlashType.off:
        return Icon(Icons.flash_off,size: 40,color: Colors.black,);
      default:
        return Icon(Icons.flash_auto,size: 40,color: Colors.black,);
    }
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final Uint8List imageBytes;

  const DisplayPictureScreen({Key? key, required this.imageBytes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: Center(
        child: Image.memory(imageBytes),
      ),
    );
  }
}