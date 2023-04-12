import 'package:flutter/material.dart';
import 'package:moodin/pages/signin_page.dart';
import 'package:moodin/config/palette.dart';

void main() {
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
        fontFamily: "Netflix",
      ),
      home: const SignInPage(),
    );
  }
}



