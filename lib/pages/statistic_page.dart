import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  _StatisticPage createState() => _StatisticPage();
}

class _StatisticPage extends State<StatisticPage> {
  // TODO: Masukkan kode untuk mengambil data mood harian
  @override
  Widget build(BuildContext context) {
    List jan = [
      {'mood': 'Happy', 'total': 13.0},
      {'mood': 'Excited', 'total': 6.0},
      {'mood': 'No Feel', 'total': 10.0},
      {'mood': 'Sad', 'total': 8.0},
      {'mood': 'Tired', 'total': 11.0}
    ];

    List feb = [
      {'mood': 'Happy', 'total': 8.0},
      {'mood': 'Excited', 'total': 10.0},
      {'mood': 'No Feel', 'total': 13.0},
      {'mood': 'Sad', 'total': 17.0},
      {'mood': 'Tired', 'total': 11.0}
    ];

    List march = [
      {'mood': 'Happy', 'total': 13.0},
      {'mood': 'Excited', 'total': 10.0},
      {'mood': 'No Feel', 'total': 5.0},
      {'mood': 'Sad', 'total': 9.0},
      {'mood': 'Tired', 'total': 12.0}
    ];

    List apr = [
      {'mood': 'Happy', 'total': 15.0},
      {'mood': 'Excited', 'total': 17.0},
      {'mood': 'No Feel', 'total': 18.0},
      {'mood': 'Sad', 'total': 9.0},
      {'mood': 'Tired', 'total': 6.0}
    ];

    List mei = [
      {'mood': 'Happy', 'total': 10.0},
      {'mood': 'Excited', 'total': 8.0},
      {'mood': 'No Feel', 'total': 12.0},
      {'mood': 'Sad', 'total': 14.0},
      {'mood': 'Tired', 'total': 11.0}
    ];

    // List bulan = [jan, feb, march, apr, mei];

    final List<Tab> tabBulan = [
      Tab(text: 'Januari'),
      Tab(text: 'Februari'),
      Tab(text: 'Maret'),
      Tab(text: 'April'),
      Tab(text: 'Mei'),
      Tab(text: 'Juni'),
      Tab(text: 'Juli'),
      Tab(text: 'Agustus'),
      // Tab(text: 'September'),
      // Tab(text: 'Oktober'),
      // Tab(text: 'November'),
      // Tab(text: 'Desember'),
    ];

    return DefaultTabController(
      length: 8,
      child: MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                  title: const Text('Mood Chart',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  bottom: TabBar(isScrollable: true, tabs: tabBulan, labelColor: Colors.black, indicatorColor: Colors.black,)),
              body: TabBarView(children: [
                //JANUARI
                ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    Container(
                      width: 300,
                      height: 60,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(72, 69, 68, 0.294),
                                blurRadius: 10,
                                offset: Offset(0, 10))
                          ]),
                      child: Text(
                        'Januari 2023',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //Chart bulan Januari
                    Container(
                      width: 300,
                      height: 250,
                      padding: EdgeInsets.all(24),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(72, 69, 68, 0.294),
                                blurRadius: 10,
                                offset: Offset(0, 10))
                          ]),
                      child: DChartBarCustom(
                          showMeasureLine: true,
                          showDomainLine: true,
                          showMeasureLabel: true,
                          showDomainLabel: true,
                          spaceBetweenItem: 10,
                          spaceDomainLinetoChart: 10,
                          spaceMeasureLinetoChart: 10,
                          radiusBar: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          max: 20,
                          listData: List.generate(jan.length, (index) {
                            Map item = jan[index];
                            return DChartBarDataCustom(
                                value: item['total'],
                                label: item['mood'],
                                showValue: true,
                                valueStyle: TextStyle(color: Colors.white));
                          })),
                    ),
                    Container(
                      width: 300,
                      height: 250,
                      padding: EdgeInsets.all(24),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(72, 69, 68, 0.294),
                                blurRadius: 10,
                                offset: Offset(0, 10))
                          ]),
                      child: DChartPie(
                        data: jan.map((e) {
                          return {'domain': e['mood'], 'measure': e['total']};
                        }).toList(),
                        fillColor: (pieData, index) {
                          switch (pieData['domain']) {
                            case 'Happy':
                              return Color.fromARGB(255, 236, 187, 255);
                            case 'Excited':
                              return Color.fromARGB(255, 255, 187, 187);
                            case 'No Feel':
                              return Color.fromARGB(255, 189, 189, 189);
                            case 'Sad':
                              return Color.fromARGB(255, 241, 255, 187);
                            case 'Tired':
                              return Color.fromARGB(255, 187, 255, 196);
                          }
                        },
                        labelPosition: PieLabelPosition.outside,
                        labelColor: Colors.black,
                        labelLineColor: Colors.black,
                        labelLineThickness: 2,
                        labelFontSize: 15,
                        labelPadding: 5,
                        pieLabel: (Map<dynamic, dynamic> pieData, int? index) {
                          return pieData['domain'] +
                              ':\n' +
                              pieData['measure'].toString();
                        },
                        donutWidth: 20,
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.all(5),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.push(context,
                    //           MaterialPageRoute(builder: (context) => tahunan()));
                    //     },
                    //     child: Text('Yearly Statistics'),
                    //     style: ButtonStyle(
                    //         padding:
                    //             MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                    //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //             RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(16)))),
                    //   ),
                    // )
                  ],
                ),
                //FEBRUARI
                ListView(padding: const EdgeInsets.all(8), children: [
                  Container(
                    width: 300,
                    height: 60,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: Text(
                      'Februari 2023',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  //CHart Bulan FEB
                  Container(
                    width: 300,
                    height: 250,
                    padding: EdgeInsets.all(24),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: DChartBarCustom(
                        showMeasureLine: true,
                        showDomainLine: true,
                        showMeasureLabel: true,
                        showDomainLabel: true,
                        spaceBetweenItem: 10,
                        spaceDomainLinetoChart: 10,
                        spaceMeasureLinetoChart: 10,
                        radiusBar: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        max: 20,
                        listData: List.generate(feb.length, (index) {
                          Map item = feb[index];
                          return DChartBarDataCustom(
                              value: item['total'],
                              label: item['mood'],
                              showValue: true,
                              valueStyle: TextStyle(color: Colors.white));
                        })),
                  ),
                  Container(
                    width: 300,
                    height: 250,
                    padding: EdgeInsets.all(24),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: DChartPie(
                      data: feb.map((e) {
                        return {'domain': e['mood'], 'measure': e['total']};
                      }).toList(),
                      fillColor: (pieData, index) {
                        switch (pieData['domain']) {
                          case 'Happy':
                            return Color.fromARGB(255, 236, 187, 255);
                          case 'Excited':
                            return Color.fromARGB(255, 255, 187, 187);
                          case 'No Feel':
                            return Color.fromARGB(255, 189, 189, 189);
                          case 'Sad':
                            return Color.fromARGB(255, 241, 255, 187);
                          case 'Tired':
                            return Color.fromARGB(255, 187, 255, 196);
                        }
                      },
                      labelPosition: PieLabelPosition.outside,
                      labelColor: Colors.black,
                      labelLineColor: Colors.black,
                      labelLineThickness: 2,
                      labelFontSize: 15,
                      labelPadding: 5,
                      pieLabel: (Map<dynamic, dynamic> pieData, int? index) {
                        return pieData['domain'] +
                            ':\n' +
                            pieData['measure'].toString();
                      },
                      donutWidth: 20,
                    ),
                  ),
                ]),
                //MARET
                ListView(padding: const EdgeInsets.all(8), children: [
                  Container(
                    width: 300,
                    height: 60,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: Text(
                      'Maret 2023',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 250,
                    padding: EdgeInsets.all(24),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: DChartBarCustom(
                        showMeasureLine: true,
                        showDomainLine: true,
                        showMeasureLabel: true,
                        showDomainLabel: true,
                        spaceBetweenItem: 10,
                        spaceDomainLinetoChart: 10,
                        spaceMeasureLinetoChart: 10,
                        radiusBar: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        max: 20,
                        listData: List.generate(march.length, (index) {
                          Map item = march[index];
                          return DChartBarDataCustom(
                              value: item['total'],
                              label: item['mood'],
                              showValue: true,
                              valueStyle: TextStyle(color: Colors.white));
                        })),
                  ),
                  Container(
                    width: 300,
                    height: 250,
                    padding: EdgeInsets.all(24),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: DChartPie(
                      data: march.map((e) {
                        return {'domain': e['mood'], 'measure': e['total']};
                      }).toList(),
                      fillColor: (pieData, index) {
                        switch (pieData['domain']) {
                          case 'Happy':
                            return Color.fromARGB(255, 236, 187, 255);
                          case 'Excited':
                            return Color.fromARGB(255, 255, 187, 187);
                          case 'No Feel':
                            return Color.fromARGB(255, 189, 189, 189);
                          case 'Sad':
                            return Color.fromARGB(255, 241, 255, 187);
                          case 'Tired':
                            return Color.fromARGB(255, 187, 255, 196);
                        }
                      },
                      labelPosition: PieLabelPosition.outside,
                      labelColor: Colors.black,
                      labelLineColor: Colors.black,
                      labelLineThickness: 2,
                      labelFontSize: 15,
                      labelPadding: 5,
                      pieLabel: (Map<dynamic, dynamic> pieData, int? index) {
                        return pieData['domain'] +
                            ':\n' +
                            pieData['measure'].toString();
                      },
                      donutWidth: 20,
                    ),
                  ),
                ]),
                //APRIL
                ListView(padding: const EdgeInsets.all(8), children: [
                  Container(
                    width: 300,
                    height: 60,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: Text(
                      'April 2023',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 250,
                    padding: EdgeInsets.all(24),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: DChartBarCustom(
                        showMeasureLine: true,
                        showDomainLine: true,
                        showMeasureLabel: true,
                        showDomainLabel: true,
                        spaceBetweenItem: 10,
                        spaceDomainLinetoChart: 10,
                        spaceMeasureLinetoChart: 10,
                        radiusBar: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        max: 20,
                        listData: List.generate(apr.length, (index) {
                          Map item = apr[index];
                          return DChartBarDataCustom(
                              value: item['total'],
                              label: item['mood'],
                              showValue: true,
                              valueStyle: TextStyle(color: Colors.white));
                        })),
                  ),
                  Container(
                    width: 300,
                    height: 250,
                    padding: EdgeInsets.all(24),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: DChartPie(
                      data: apr.map((e) {
                        return {'domain': e['mood'], 'measure': e['total']};
                      }).toList(),
                      fillColor: (pieData, index) {
                        switch (pieData['domain']) {
                          case 'Happy':
                            return Color.fromARGB(255, 236, 187, 255);
                          case 'Excited':
                            return Color.fromARGB(255, 255, 187, 187);
                          case 'No Feel':
                            return Color.fromARGB(255, 189, 189, 189);
                          case 'Sad':
                            return Color.fromARGB(255, 241, 255, 187);
                          case 'Tired':
                            return Color.fromARGB(255, 187, 255, 196);
                        }
                      },
                      labelPosition: PieLabelPosition.outside,
                      labelColor: Colors.black,
                      labelLineColor: Colors.black,
                      labelLineThickness: 2,
                      labelFontSize: 15,
                      labelPadding: 5,
                      pieLabel: (Map<dynamic, dynamic> pieData, int? index) {
                        return pieData['domain'] +
                            ':\n' +
                            pieData['measure'].toString();
                      },
                      donutWidth: 20,
                    ),
                  ),
                ]),
                //MEI
                ListView(padding: const EdgeInsets.all(8), children: [
                  Container(
                    width: 300,
                    height: 60,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: Text(
                      'Mei 2023',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 250,
                    padding: EdgeInsets.all(24),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: DChartBarCustom(
                        showMeasureLine: true,
                        showDomainLine: true,
                        showMeasureLabel: true,
                        showDomainLabel: true,
                        spaceBetweenItem: 10,
                        spaceDomainLinetoChart: 10,
                        spaceMeasureLinetoChart: 10,
                        radiusBar: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        max: 20,
                        listData: List.generate(mei.length, (index) {
                          Map item = mei[index];
                          return DChartBarDataCustom(
                              value: item['total'],
                              label: item['mood'],
                              showValue: true,
                              valueStyle: TextStyle(color: Colors.white));
                        })),
                  ),
                  Container(
                    width: 300,
                    height: 250,
                    padding: EdgeInsets.all(24),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: DChartPie(
                      data: mei.map((e) {
                        return {'domain': e['mood'], 'measure': e['total']};
                      }).toList(),
                      fillColor: (pieData, index) {
                        switch (pieData['domain']) {
                          case 'Happy':
                            return Color.fromARGB(255, 236, 187, 255);
                          case 'Excited':
                            return Color.fromARGB(255, 255, 187, 187);
                          case 'No Feel':
                            return Color.fromARGB(255, 189, 189, 189);
                          case 'Sad':
                            return Color.fromARGB(255, 241, 255, 187);
                          case 'Tired':
                            return Color.fromARGB(255, 187, 255, 196);
                        }
                      },
                      labelPosition: PieLabelPosition.outside,
                      labelColor: Colors.black,
                      labelLineColor: Colors.black,
                      labelLineThickness: 2,
                      labelFontSize: 15,
                      labelPadding: 5,
                      pieLabel: (Map<dynamic, dynamic> pieData, int? index) {
                        return pieData['domain'] +
                            ':\n' +
                            pieData['measure'].toString();
                      },
                      donutWidth: 20,
                    ),
                  ),
                ]),
                //JUNI
                ListView(padding: const EdgeInsets.all(8), children: [
                  Container(
                    width: 300,
                    height: 60,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: Text(
                      'Juni 2023',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
                //JULI
                ListView(padding: const EdgeInsets.all(8), children: [
                  Container(
                    width: 300,
                    height: 60,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: Text(
                      'Juli 2023',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
                //AGUSTUS
                ListView(padding: const EdgeInsets.all(8), children: [
                  Container(
                    width: 300,
                    height: 60,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(72, 69, 68, 0.294),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    child: Text(
                      'Aguatus 2023',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
              ]))),
    );
  }
}
