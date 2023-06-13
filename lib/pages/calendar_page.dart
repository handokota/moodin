import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firebase_options.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  Map<String, List<dynamic>> mySelectedEvents = {};
  Map<String, String> moodTexts = {
    '😃': 'Rad',
    '😊': 'Happy',
    '😐': 'Meh',
    '😞': 'Bad',
    '😫': 'Awful',
    // Tambahkan mood dan teksnya di sini
  };
  final titleController = TextEditingController();
  final descpController = TextEditingController();
  String mood = '';

  CollectionReference<Map<String, dynamic>> eventsCollection =
  FirebaseFirestore.instance.collection('events');

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    loadPreviousEvents();
  }

  loadPreviousEvents() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await eventsCollection.get();

    setState(() {
      mySelectedEvents = snapshot.docs.fold<Map<String, List<dynamic>>>(
        {},
            (previousValue, doc) {
          Map<String, dynamic> data = doc.data();
          List<dynamic>? events = data['events'];
          previousValue[data['date']] = events ?? [];
          return previousValue;
        },
      );
    });
  }

  List<dynamic> _listOfDayEvents(DateTime dateTime) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return mySelectedEvents[formattedDate] ?? [];
  }

  Future<void> _showAddEventDialog() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEventScreen(
          onSave: (event) {
            String formattedDate =
            DateFormat('yyyy-MM-dd').format(_selectedDate!);

            setState(() {
              if (mySelectedEvents[formattedDate] != null) {
                mySelectedEvents[formattedDate]!.add(event);
              } else {
                mySelectedEvents[formattedDate] = [event];
              }
            });

            eventsCollection.doc(formattedDate).set({
              'date': formattedDate,
              'events': mySelectedEvents[formattedDate],
            });

            titleController.clear();
            descpController.clear();
            setState(() {
              mood = '';
            });

            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _updateMood(String selectedMood) {
    setState(() {
      mood = selectedMood;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Mood",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TableCalendar(
                firstDay: DateTime.utc(2022),
                lastDay: DateTime.utc(2030),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDate, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(
                        () {
                      _selectedDate = selectedDay;
                      _focusedDay = focusedDay;
                    },
                  );
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                eventLoader: _listOfDayEvents,
                calendarStyle: const CalendarStyle(
                  weekendTextStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
                weekendDays: const [6],
                headerStyle: HeaderStyle(
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  headerMargin: const EdgeInsets.only(bottom: 16.0),
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  formatButtonTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  formatButtonDecoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                  ),
                  leftChevronIcon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  rightChevronIcon: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ..._listOfDayEvents(_selectedDate!).map((myEvents) => Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '${myEvents['eventMood']}',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('Title: ${myEvents['eventTitle']}'),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description: ${myEvents['eventDescp']}'),
                      Text(
                        'Mood: ${moodTexts.containsKey(myEvents['eventMood']) ? moodTexts[myEvents['eventMood']] : myEvents['eventMood']}',
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Icon(Icons.add),
        backgroundColor: const Color(0xFF000000),
      ),
    );
  }
}

class AddEventScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const AddEventScreen({Key? key, required this.onSave}) : super(key: key);

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final titleController = TextEditingController();
  final descpController = TextEditingController();
  String mood = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Mood"),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: descpController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 16),
              const Text(
                'How are you today?',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  MoodOptionWidget(
                    image: 'rad.png',
                    text: 'Rad',
                    isSelected: mood == '😃',
                    onTap: () {
                      _updateMood('😃');
                    },
                  ),
                  MoodOptionWidget(
                    image: 'good.png',
                    text: 'Happy',
                    isSelected: mood == '😊',
                    onTap: () {
                      _updateMood('😊');
                    },
                  ),
                  MoodOptionWidget(
                    image: 'meh.png',
                    text: 'Meh',
                    isSelected: mood == '😐',
                    onTap: () {
                      _updateMood('😐');
                    },
                  ),
                  MoodOptionWidget(
                    image: 'bad.png',
                    text: 'Bad',
                    isSelected: mood == '😞',
                    onTap: () {
                      _updateMood('😞');
                    },
                  ),
                  MoodOptionWidget(
                    image: 'awful.png',
                    text: 'Awful',
                    isSelected: mood == '😫',
                    onTap: () {
                      _updateMood('😫');
                    },
                  ),
                ],
              ),
              Divider(),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isEmpty &&
                      descpController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Required title, description, and mood'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  } else if (mood.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a mood'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  final event = {
                    "eventTitle": titleController.text,
                    "eventDescp": descpController.text,
                    "eventMood": mood,
                  };

                  widget.onSave(event);
                },
                child: const Text('Add Mood'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateMood(String selectedMood) {
    setState(() {
      mood = selectedMood;
    });
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
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.black : Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
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
          ),
        )
      ],
    );
  }
}

class AppColors {
  static const primaryColor = Color(0xFF000000);
}


class AppSizes {
  static const double borderRadius = 10.0;
}
