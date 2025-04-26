import 'dart:io';
//import 'package:fatigue_detect/screens/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isCameraAccessEnabled = true;
  bool isPushNotificationsEnabled = true;
  String userName = 'Karan Kadam'; // Updated default name
  File? _profileImage;
  String? _savedImagePath;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  bool isImagePickerAvailable = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _checkImagePickerAvailability();
  }

  // Check if image picker is available
Future<void> _checkImagePickerAvailability() async {
  try {
    // Corrected method call
    await ImagePicker().pickImage(source: ImageSource.gallery);
  } catch (e) {
    setState(() {
      isImagePickerAvailable = false;
    });
    print('Image picker not available: $e');
  }
}

  // Load saved profile data
  Future<void> _loadProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        userName = prefs.getString('userName') ?? 'Karan Kadam';
        _savedImagePath = prefs.getString('profileImagePath');
        isCameraAccessEnabled = prefs.getBool('cameraAccess') ?? true;
        isPushNotificationsEnabled = prefs.getBool('pushNotifications') ?? true;
      });
      _nameController.text = userName;
    } catch (e) {
      print('Error loading profile data: $e');
    }
  }

  // Save profile data
  Future<void> _saveProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', userName);
      if (_savedImagePath != null) {
        await prefs.setString('profileImagePath', _savedImagePath!);
      }
      await prefs.setBool('cameraAccess', isCameraAccessEnabled);
      await prefs.setBool('pushNotifications', isPushNotificationsEnabled);
    } catch (e) {
      print('Error saving profile data: $e');
    }
  }

  // Image picker function with more robust error handling
  Future<void> _pickImage() async {
    if (!isImagePickerAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image picker not available on this device')),
      );
      return;
    }

    try {
      // Use the newer API properly
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
          _savedImagePath = pickedFile.path;
        });
        await _saveProfileData();
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not pick image. Please ensure app has permission to access photos')),
      );
    }
  }

  // Alternative image picking approach for platforms with issues
  Future<void> _pickImageAlternative() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image upload functionality is not available at this time')),
    );
  }

  // Edit name dialog
  void _showEditNameDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text('Edit Name', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: _nameController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter your name',
            hintStyle: TextStyle(color: Colors.white70),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = _nameController.text;
              });
              _saveProfileData();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Hero(
                    tag: 'profile-pic',
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: _getProfileImage(),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: isImagePickerAvailable ? _pickImage : _pickImageAlternative,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          child: Text('Upload', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _showEditNameDialog,
                    icon: Icon(Icons.edit, color: Colors.white),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Permissions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.camera_alt, color: Colors.white70),
                          SizedBox(width: 10),
                          Text('Camera Access', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Switch(
                        value: isCameraAccessEnabled,
                        onChanged: (value) {
                          setState(() {
                            isCameraAccessEnabled = value;
                          });
                          _saveProfileData();
                        },
                        activeColor: Colors.purple,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.notifications, color: Colors.white70),
                          SizedBox(width: 10),
                          Text('Push Notifications', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Switch(
                        value: isPushNotificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            isPushNotificationsEnabled = value;
                          });
                          _saveProfileData();
                        },
                        activeColor: Colors.purple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add sign-out functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Signed out successfully')),
                  );
                },
                icon: Icon(Icons.logout),
                label: Text('Sign Out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800],
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get profile image from file or asset
  ImageProvider _getProfileImage() {
    if (_profileImage != null) {
      return FileImage(_profileImage!);
    } else if (_savedImagePath != null && File(_savedImagePath!).existsSync()) {
      return FileImage(File(_savedImagePath!));
    } else {
      return AssetImage('assets/profile.jpg');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}