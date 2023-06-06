import 'package:flutter/material.dart';
import 'package:moodin/pages/signin_page.dart';
import 'package:moodin/config/palette.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MoodTrackerApp());
}

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodIn',
      theme: ThemeData(
        primarySwatch: Palette.Dark,
        fontFamily: "Inter",
      ),
      home: const SignInPage(),
    );
  }
}



