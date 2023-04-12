import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
// import 'package:moodin/pages/statistic_page.dart';
import 'package:moodin/pages/calendar_page.dart';
import 'package:moodin/pages/profile_page.dart';
import 'package:moodin/pages/about_page.dart';
import 'package:moodin/config/palette.dart';

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
        fontFamily: "Netflix",
      ),
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.show_chart),
            //   label: 'Statistic',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoodIn'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 0),
                ),
              ],
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
                EmojiFeedback(
                  animDuration: const Duration(milliseconds: 300),
                  curve: Curves.bounceIn,
                  inactiveElementScale: .5,
                  onChanged: (value) {
                    print(value);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Icon(Icons.note),
                    SizedBox(width: 8),
                    Text(
                      'Note',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Type your note here...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
              return SizedBox(
                height: 300,
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
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: const Icon(Icons.calendar_today),
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
                            leading: const Icon(Icons.access_time),
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
                    EmojiFeedback(
                      animDuration: const Duration(milliseconds: 300),
                      curve: Curves.bounceOut,
                      inactiveElementScale: .5,
                      onChanged: (value) {
                        print(value);
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MoodOptionWidget extends StatelessWidget {
  final String emoji;
  final String text;

  const MoodOptionWidget({super.key, required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 36),
        ),
        const SizedBox(height: 8),
        Text(text),
      ],
    );
  }
}