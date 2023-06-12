import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Referensi Utama : https://www.youtube.com/watch?v=d4KFeRdZMcw
//Referensi : https://stackoverflow.com/questions/62108798/how-to-save-page-state-on-revisit-in-flutter
// Referensi : https://medium.com/unitechie/flutter-tutorial-image-picker-from-camera-gallery-c27af5490b74
//Referensi : https://stackoverflow.com/questions/62128847/how-to-save-set-image-of-pickedfile-type-to-a-image-in-flutter
//https://stackoverflow.com/questions/59558604/why-do-we-use-the-dispose-method-in-flutter-dart-code
//referensi : https://protocoderspoint.com/flutter-profile-page-ui-design-social-media-2/
//Referensi : https://stackoverflow.com/questions/71566069/edit-user-profile-page-and-profile-picture-using-real-time-database-flutter

//Referensi : https://stackoverflow.com/questions/62108798/how-to-save-page-state-on-revisit-in-flutter

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _jobTitleController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  File? _profileImage;
  final picker = ImagePicker();
  final CollectionReference _profileCollection =
  FirebaseFirestore.instance.collection('profiles');

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Anonymous');
    _jobTitleController = TextEditingController(text: 'Software Engineer');
    _emailController = TextEditingController(text: 'email@example.com');
    _phoneController = TextEditingController(text: '+62 823 4761567');
    _profileImage = null;
    _loadProfilePicture();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profileImage');
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  Future<void> _saveProfilePicture(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImage', imagePath);
  }

  Future<void> _removeProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('profileImage');
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        _saveProfilePicture(pickedFile.path);
      });
    }
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 80.0,
        backgroundColor: Colors.grey[200],
        backgroundImage: _profileImage != null
            ? FileImage(_profileImage!) as ImageProvider<Object>
            : AssetImage('assets/profile/profile_image.jpeg'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconTheme(
            data: const IconThemeData(color: Colors.black),
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editProfile(context),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildProfileImage(),
            const SizedBox(height: 20.0),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _nameController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: _jobTitleController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Job Title',
              ),
            ),
            TextFormField(
              controller: _emailController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: _phoneController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editProfile(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfilePage(
          name: _nameController.text,
          jobTitle: _jobTitleController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          profileCollection: _profileCollection,
        ),
      ),
    );
    if (result != null && result is Map<String, String>) {
      setState(() {
        _nameController.text = result['name']!;
        _jobTitleController.text = result['jobTitle']!;
        _emailController.text = result['email']!;
        _phoneController.text = result['phone']!;

        final snackBar = SnackBar(content: Text('Profile updated!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }
}

class EditProfilePage extends StatefulWidget {
  final String name;
  final String jobTitle;
  final String email;
  final String phone;
  final CollectionReference profileCollection;

  const EditProfilePage({
    Key? key,
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.phone,
    required this.profileCollection,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _jobTitleController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _jobTitleController = TextEditingController(text: widget.jobTitle);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => _saveProfile(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: _jobTitleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a job title';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Job Title',
                ),
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfile(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final result = {
        'name': _nameController.text,
        'jobTitle': _jobTitleController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      };

      try {
        await widget.profileCollection.add(result);
        Navigator.pop(context, result);
      } catch (e) {
        print('Error saving profile: $e');
        final snackBar = SnackBar(content: Text('Failed to save profile'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}