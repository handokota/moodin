import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

class MoodGrafik extends StatefulWidget {
  @override
  _MoodGrafik createState() => _MoodGrafik();
}

class MoodData {
  final DateTime date;
  final int moodValue;

  MoodData(this.date, this.moodValue);
}

class _MoodGrafik extends State<MoodGrafik> {
  // TODO: Masukkan kode untuk mengambil data mood harian
  List<MoodData> _moodDataList = [
    MoodData(DateTime(2023, 4, 1), 3),
    MoodData(DateTime(2023, 4, 2), 4),
    MoodData(DateTime(2023, 4, 3), 2),
    MoodData(DateTime(2023, 4, 4), 5),
    MoodData(DateTime(2023, 4, 5), 4),
    MoodData(DateTime(2023, 4, 6), 1),
    MoodData(DateTime(2023, 4, 7), 3),
  ];

  List<charts.Series<MoodData, DateTime>> _seriesList =
  []; // List untuk menyimpan data yang akan digunakan untuk membuat grafik

  @override
  void initState() {
    super.initState();
    // TODO: Masukkan kode untuk mengolah data mood harian
    _seriesList.add(
      charts.Series(
        id: 'Mood',
        data: _moodDataList,
        domainFn: (MoodData mood, _) => mood.date,
        measureFn: (MoodData mood, _) => mood.moodValue,
        colorFn: (MoodData, __) => charts.MaterialPalette.black,
        displayName: 'Mood',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Grafik Mood"),
          backgroundColor: Colors.black,
        ),
        body: Container(
          width: 500,
          height: 300,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(72, 69, 68, 0.294),
                    blurRadius: 10,
                    offset: Offset(0, 15))
              ]),
          /*gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  // end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFF8C3B),
                    Color(0xFFFF6365),
                  ])), */
          padding: EdgeInsets.all(16),
          child: charts.TimeSeriesChart(
            _seriesList, // Data untuk membuat grafik
            animate: true,
            animationDuration: Duration(milliseconds: 500),
          ),
        ),
      ),
    );
  }
}
