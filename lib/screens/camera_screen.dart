import 'package:flutter/material.dart';
import 'profile_screen.dart'; // Import your profile screen

class CameraScreen extends StatelessWidget {
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
              tag: 'profile-pic', // Hero tag
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 60, color: Colors.white38),
            SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Recording Started')),
          );
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.videocam, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}