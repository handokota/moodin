import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:moodin/pages/statistic_page.dart';
import 'package:moodin/pages/calendar_page.dart';
import 'package:moodin/pages/profile_page.dart';
import 'package:moodin/pages/about_page.dart';
import 'package:moodin/config/palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    // MoodGrafik(),
    const CalendarPage(),
    const ProfilePage(),
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodIn',
      theme: ThemeData(
        primarySwatch: Palette.Dark,
        fontFamily: "Inter",
      ),
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 32, color: Colors.black),
              activeIcon: Icon(Icons.home, size: 32, color: Colors.black),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_outlined, size: 28, color: Colors.black),
              activeIcon: Icon(Icons.event_note, size: 28, color: Colors.black),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined, size: 28, color: Colors.black),
              activeIcon: Icon(Icons.account_circle, size: 28, color: Colors.black),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline, size: 28, color: Colors.black),
              activeIcon: Icon(Icons.info, size: 28, color: Colors.black),
              label: 'About',
            ),
          ],
        ),

      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController noteController = TextEditingController();
  String selectedMood = '';

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _eden = CameraPosition(
      target: LatLng(-6.978664380471165, 107.62997604039901),
      zoom: 13,
  );

  void saveMood() {
    final String note = noteController.text.trim();
    if (note.isNotEmpty && selectedMood.isNotEmpty) {
      FirebaseFirestore.instance.collection('moods').add({
        'note': note,
        'mood': selectedMood,
        'timestamp': DateTime.now(),
      });
      noteController.clear();
      setState(() {
        selectedMood = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mood saved')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a mood and enter a note')),
      );
    }
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'MoodIn',
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
              icon: const Icon(Icons.search),
              onPressed: () {
                // TODO
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
                border: Border.all(color: const Color(0xFFdbdcdf), width: 1),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'How are you today?',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MoodOptionWidget(
                        image: 'rad.png',
                        text: 'Rad',
                        isSelected: selectedMood == '😃',
                        onTap: () {
                          setState(() {
                            selectedMood = '😃';
                          });
                        },
                      ),
                      MoodOptionWidget(
                        image: 'good.png',
                        text: 'Good',
                        isSelected: selectedMood == '😊',
                        onTap: () {
                          setState(() {
                            selectedMood = '😊';
                          });
                        },
                      ),
                      MoodOptionWidget(
                        image: 'meh.png',
                        text: 'Meh',
                        isSelected: selectedMood == '😐',
                        onTap: () {
                          setState(() {
                            selectedMood = '😐';
                          });
                        },
                      ),
                      MoodOptionWidget(
                        image: 'bad.png',
                        text: 'Bad',
                        isSelected: selectedMood == '😞',
                        onTap: () {
                          setState(() {
                            selectedMood = '😞';
                          });
                        },
                      ),
                      MoodOptionWidget(
                        image: 'awful.png',
                        text: 'Awful',
                        isSelected: selectedMood == '😫',
                        onTap: () {
                          setState(() {
                            selectedMood = '😫';
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(Icons.edit_note, color: Color(0xFF0694F0)),
                      SizedBox(width: 8),
                      Text(
                        'Note',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: noteController,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Add note',
                      filled: true,
                      fillColor: const Color(0xFFEDECF0),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                      // contentPadding: const EdgeInsets.all(8.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      onPressed: saveMood,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ), backgroundColor: const Color(0xFF0694f0), // Set the background color to EDECF0
                        elevation: 0, // Remove the button shadow
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 16, right: 16),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xFF0694F0)),
                  SizedBox(width: 8),
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: SizedBox(
                  height: 250,
                  child: GoogleMap(
                    initialCameraPosition: _eden,
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 16, right: 16),
              child: Row(
                children: [
                  Icon(Icons.recommend, color: Color(0xFF0694F0)),
                  SizedBox(width: 8),
                  Text(
                    'For you',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CustomYoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: '_NbJXsts9K8',
                    flags: const YoutubePlayerFlags(
                        autoPlay: true,
                        mute: false,
                        loop: true,
                        enableCaption: false
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
            ),
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 400,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'How are you?',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          Icon(Icons.edit_note, color: Color(0xFF0694F0)),
                          SizedBox(width: 8),
                          Text(
                            'Note',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: noteController,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Add note',
                          filled: true,
                          fillColor: const Color(0xFFEDECF0),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                          // contentPadding: const EdgeInsets.all(8.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: const Icon(Icons.event_note, color: Color(0xFF0694F0)),
                              title: Text(
                                DateFormat.yMMMMd().format(DateTime.now()),
                              ),
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              leading: const Icon(Icons.access_time, color: Color(0xFF0694F0)),
                              title: Text(
                                TimeOfDay.now().format(context),
                              ),
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MoodOptionModal(
                            image: 'rad.png',
                            text: 'Rad',
                            isSelectedModal: selectedMood == '😃',
                            onTapModal: () {
                              setState(() {
                                selectedMood = '😃';
                              });
                            },
                          ),
                          MoodOptionModal(
                            image: 'good.png',
                            text: 'Good',
                            isSelectedModal: selectedMood == '😊',
                            onTapModal: () {
                              setState(() {
                                selectedMood = '😊';
                              });
                            },
                          ),
                          MoodOptionModal(
                            image: 'meh.png',
                            text: 'Meh',
                            isSelectedModal: selectedMood == '😐',
                            onTapModal: () {
                              setState(() {
                                selectedMood = '😐';
                              });
                            },
                          ),
                          MoodOptionModal(
                            image: 'bad.png',
                            text: 'Bad',
                            isSelectedModal: selectedMood == '😞',
                            onTapModal: () {
                              setState(() {
                                selectedMood = '😞';
                              });
                            },
                          ),
                          MoodOptionModal(
                            image: 'awful.png',
                            text: 'Awful',
                            isSelectedModal: selectedMood == '😫',
                            onTapModal: () {
                              setState(() {
                                selectedMood = '😫';
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 80,
                        child: ElevatedButton(
                          onPressed: saveMood,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ), backgroundColor: const Color(0xFF0694f0), // Set the background color to EDECF0
                            elevation: 0, // Remove the button shadow
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        backgroundColor: const Color(0xFF0694f0),
        child: const Icon(Icons.add),
      ),

    );
  }
}

class MoodOptionWidget extends StatelessWidget {
  final String image;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const MoodOptionWidget({
    Key? key,
    required this.image,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            'assets/images/$image',
            width: 48,
            height: 48,
            color: isSelected ? Colors.blue : null,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.blue : null,
            ),
          ),
        ],
      ),
    );
  }
}


class MoodOptionModal extends StatelessWidget {
  final String image;
  final String text;
  final bool isSelectedModal;
  final VoidCallback onTapModal;

  const MoodOptionModal({
    Key? key,
    required this.image,
    required this.text,
    required this.isSelectedModal,
    required this.onTapModal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapModal,
      child: Column(
        children: [
          Image.asset(
            'assets/images/$image',
            width: 48,
            height: 48,
            color: isSelectedModal ? Colors.blue : null,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: isSelectedModal ? Colors.blue : null,
            ),
          ),
        ],
      ),
    );
  }
}


class CustomYoutubePlayer extends YoutubePlayer {
  CustomYoutubePlayer({
    Key? key,
    required YoutubePlayerController controller,
    bool showVideoProgressIndicator = false,
    Color? progressIndicatorColor,
  }) : super(
    key: key,
    controller: controller,
    showVideoProgressIndicator: showVideoProgressIndicator,
    progressIndicatorColor: progressIndicatorColor,
    bottomActions: [],
  );
}
