import 'package:fatigue_detect/screens/camera_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool soundAlerts = true;
  bool vibrationAlerts = true;
  bool darkMode = true;
  double detectionSensitivity = 0.5;
  double eyeBlinkThreshold = 0.5;
  TextEditingController intervalController = TextEditingController(text: '5');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraScreen()),
    );
  },
),
        title: Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Settings Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('App Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  _buildSwitchTile(Icons.notifications, 'Sound Alerts', soundAlerts, (value) {
                    setState(() {
                      soundAlerts = value;
                    });
                  }),
                  _buildSwitchTile(Icons.vibration, 'Vibration Alerts', vibrationAlerts, (value) {
                    setState(() {
                      vibrationAlerts = value;
                    });
                  }),
                  _buildSwitchTile(Icons.dark_mode, 'Dark Mode', darkMode, (value) {
                    setState(() {
                      darkMode = value;
                    });
                  }),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Detection Settings Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Detection Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('Detection Sensitivity'),
                  Slider(
                    value: detectionSensitivity,
                    min: 0,
                    max: 1,
                    activeColor: Colors.purple,
                    onChanged: (value) {
                      setState(() {
                        detectionSensitivity = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Low'),
                      Text('High'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Eye Blink Threshold'),
                  Slider(
                    value: eyeBlinkThreshold,
                    min: 0,
                    max: 1,
                    activeColor: Colors.purple,
                    onChanged: (value) {
                      setState(() {
                        eyeBlinkThreshold = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Low'),
                      Text('High'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Detection Interval (seconds)'),
                  SizedBox(height: 8),
                  TextField(
                    controller: intervalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white70),
            SizedBox(width: 10),
            Text(title, style: TextStyle(fontSize: 16)),
          ],
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.purple,
        ),
      ],
    );
  }
}