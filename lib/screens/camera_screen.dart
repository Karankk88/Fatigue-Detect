import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'profile_screen.dart';

// Global variable to store available cameras
List<CameraDescription> cameras = [];

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  bool _isCameraRunning = false;
  bool _isDetecting = false;

  @override
  void initState() {
    super.initState();
    loadCameras();
  }

  Future<void> loadCameras() async {
    cameras = await availableCameras();
  }

  Future<void> startCamera() async {
    if (cameras.isEmpty) {
      print('No cameras found');
      return;
    }
    _cameraController = CameraController(
      cameras[0], // First available camera
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController?.initialize();
    if (!mounted) return;
    setState(() {
      _isCameraRunning = true;
    });

    // Start the image stream for detection
    _cameraController?.startImageStream((CameraImage image) {
      if (!_isDetecting) {
        _isDetecting = true;

        detectFatigue(image);

        _isDetecting = false;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Camera started')),
    );
  }

  Future<void> stopCamera() async {
    if (_cameraController != null) {
      await _cameraController?.stopImageStream();
      await _cameraController?.dispose();
      _cameraController = null;
      setState(() {
        _isCameraRunning = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera stopped')),
      );
    }
  }

  void toggleCamera() {
    if (_isCameraRunning) {
      stopCamera();
    } else {
      startCamera();
    }
  }

  void detectFatigue(CameraImage image) {
    // Here you can connect your ML model
    print('Detecting fatigue on camera frame...');
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Driver Fatigue Detection'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            icon: Hero(
              tag: 'profile-pic',
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
                radius: 18,
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: _cameraController == null || !_cameraController!.value.isInitialized
            ? Text(
                'Camera is OFF\nTap button to start',
                style: TextStyle(color: Colors.white70, fontSize: 18),
                textAlign: TextAlign.center,
              )
            : CameraPreview(_cameraController!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleCamera,
        backgroundColor: _isCameraRunning ? Colors.red : Colors.deepPurple,
        child: Icon(
          _isCameraRunning ? Icons.stop : Icons.videocam,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
 