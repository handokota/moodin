import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
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
  late Database _database;

  Future<void> _loadProfileData() async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('profiles')
        .doc('profile')
        .get();

    if (documentSnapshot.exists) {
      final profile = documentSnapshot.data();
      setState(() {
        _nameController.text = profile?['name'] ?? '';
        _jobTitleController.text = profile?['jobTitle'] ?? '';
        _emailController.text = profile?['email'] ?? '';
        _phoneController.text = profile?['phone'] ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Anonymous');
    _jobTitleController = TextEditingController(text: 'Software Engineer');
    _emailController = TextEditingController(text: 'email@example.com');
    _phoneController = TextEditingController(text: '+62 823 4761567');
    _profileImage = null;
    _initDatabase();
    _loadProfilePicture();
    _loadProfileData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _database.close();
    super.dispose();
  }

  Future<void> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'profile_database.db');

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE IF NOT EXISTS profile ('
              'id INTEGER PRIMARY KEY,'
              'name TEXT,'
              'jobTitle TEXT,'
              'email TEXT,'
              'phone TEXT,'
              'profileImage TEXT'
              ')');
        });
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
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _editProfile(context),
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
          database: _database,
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
  final Database database;

  const EditProfilePage({
    Key? key,
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.phone,
    required this.profileCollection,
    required this.database,
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

  Future<void> _loadProfileData() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'profile_database.db');
    final database = await openDatabase(path, version: 1);

    final List<Map<String, dynamic>> result =
    await database.rawQuery('SELECT * FROM profile');

    if (result.isNotEmpty) {
      final profile = result.first;
      setState(() {
        _nameController.text = profile['name'];
        _jobTitleController.text = profile['jobTitle'];
        _emailController.text = profile['email'];
        _phoneController.text = profile['phone'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _jobTitleController = TextEditingController(text: widget.jobTitle);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
    _loadProfileData();
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
            onPressed: () => _updateProfile(context),
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
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _jobTitleController,
                decoration: InputDecoration(
                  labelText: 'Job Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your job title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  void _updateProfile(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final jobTitle = _jobTitleController.text;
      final email = _emailController.text;
      final phone = _phoneController.text;

      widget.profileCollection.doc('profile').update({
        'name': name,
        'jobTitle': jobTitle,
        'email': email,
        'phone': phone,
      });

      widget.database.transaction((txn) async {
        await txn.rawUpdate(
          'UPDATE profile SET name=?, jobTitle=?, email=?, phone=? WHERE id=?',
          [name, jobTitle, email, phone, 1],
        );
      });

      Navigator.pop(
        context,
        {
          'name': name,
          'jobTitle': jobTitle,
          'email': email,
          'phone': phone,
        },
      );
    }
  }
}
