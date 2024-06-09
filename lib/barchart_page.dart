import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_database/firebase_database.dart';
import 'package:cnc_crud/product.dart';
import 'time_widget.dart';

class BarChartPage extends StatefulWidget {
  final int machineId;

  BarChartPage(this.machineId);

  @override
  State<BarChartPage> createState() => _BarchartPageState();
}

class _BarchartPageState extends State<BarChartPage> {
  DateTime _toggleTime = DateTime.now();
  List<Report> reports = [];
  int productMax = 0;

  void _handleToggleTime(DateTime toggleTime) {
    _toggleTime = toggleTime;
    fetchData();
  }

  Future<void> fetchData() async {
    DatabaseReference _testRef =
        await FirebaseDatabase.instance.ref().child('products');
    final snapshot = await _testRef.get();
    final dynamicList = snapshot.value as List<Object?>;
    Map<String, int> reportMap = {};
    List<Report> reportList = [];
    var lastDayOfMonth = DateTime(_toggleTime.year, _toggleTime.month + 1, 0);
    var dateDelivery = List<DateTime>.generate(lastDayOfMonth.day,
        (i) => DateTime(_toggleTime.year, _toggleTime.month, i + 1));
    for (var date in dateDelivery) {
      String stringDate = DateFormat('dd/MM/yyyy').format(date);
      reportMap.addEntries({stringDate: 0}.entries);
    }
    dynamicList.forEach((element) {
      String el = jsonEncode(element);
      Map<String, dynamic> myMap = jsonDecode(el);
      Product product = Product.fromJson(myMap);
      if (product.machineId == widget.machineId &&
          reportMap.containsKey(product.update)) {
        reportMap[product.update] = reportMap[product.update]! + 1;
        // listProducts.add(product);
      }
    });

    for (String key in reportMap.keys) {
      if (reportMap[key]! > productMax) {
        productMax = reportMap[key]!;
      }
      Report report = Report(key, reportMap[key]!);
      reportList.add(report);
    }

    setState(() {
      reports = reportList;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biểu đồ cột'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: MediaQuery.of(context).size.width *
                1, // Tăng chiều rộng để hiển thị rõ hơn
            height: MediaQuery.of(context).size.height * 1,
            child: Column(
              children: [
                Time(_handleToggleTime),
                Expanded(
                  child: BarChartWidget(reports, productMax),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class BarChartPage extends StatelessWidget {
//   final int machineId;
//   late DateTime toggleTime;
//
//   BarChartPage(this.machineId);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Biểu đồ cột'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Container(
//             width: MediaQuery.of(context).size.width *
//                 1, // Tăng chiều rộng để hiển thị rõ hơn
//             height: MediaQuery.of(context).size.height * 1,
//             child: Column(
//               children: [
//                 Time(_handleData),
//                 Expanded(
//                   child: BarChartWidget(machineId, toggleTime),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class BarChartWidget extends StatefulWidget {
  final List<Report> reports;
  final int productMax;

  BarChartWidget(this.reports, this.productMax);

  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  @override
  void initState() {
    super.initState();
    // _testRef.onValue.listen((event) {
    //   // print(event.snapshot.value.runtimeType);
    //   final dynamicList = event.snapshot.value as List<Object?>;
    //   List<Product> listProducts = [];
    //   dynamicList.forEach((element) {
    //     String el = jsonEncode(element);
    //     Map<String, dynamic> myMap = jsonDecode(el);
    //     Product product = Product.fromJson(myMap);
    //     if (product.machineId == widget.machineId) {
    //       listProducts.add(product);
    //     }
    //   });
    //   setState(() {
    //     products = listProducts;
    //   });
    // });
  }

  // void _handleToggleTime(DateTime dateTime) {
  //   setState(() {
  //     selectedTime = dateTime;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BarChartWithSecondaryAxis.withSampleData(
        widget.reports, widget.productMax);
  }
}

class BarChartWithSecondaryAxis extends StatelessWidget {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  final List<charts.Series<Report, String>> seriesList;
  final bool animate;
  final int productMax;

  BarChartWithSecondaryAxis(this.seriesList,
      {this.animate = true, this.productMax = 0});

  factory BarChartWithSecondaryAxis.withSampleData(List<Report> barProducts,int productMax) {
    return BarChartWithSecondaryAxis(
      _createSampleData(barProducts),
      animate: false,productMax: productMax,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.OrdinalComboChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec:
            charts.BasicNumericTickProviderSpec(desiredTickCount: 4),
        viewport: charts.NumericExtents(0, productMax),
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(labelRotation: 60),
      ),
      secondaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec:
            charts.BasicNumericTickProviderSpec(desiredTickCount: 4),
        viewport: charts.NumericExtents(0, 24),
        renderSpec: charts.GridlineRendererSpec(
          axisLineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.transparent,
          ),
          labelAnchor: charts.TickLabelAnchor.inside,
          labelJustification: charts.TickLabelJustification.inside,
          labelRotation: 0,
        ),
      ),
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.top,
          horizontalFirst: false,
          desiredMaxRows: 2,
          cellPadding: EdgeInsets.only(right: 10.0, bottom: 10.0),
        ),
      ],
    );
  }

  static List<charts.Series<Report, String>> _createSampleData(
      List<Report> list) {
    print(list);
    return [
      charts.Series<Report, String>(
        id: 'products',
        domainFn: (sales, _) => sales.reportDate,
        measureFn: (sales, _) => sales.productTotal,
        data: list,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
      // charts.Series<Report, String>(
      //   id: 'time',
      //   domainFn: (sales, _) => sales.reportDate,
      //   measureFn: (sales, _) => sales.productTotal,
      //   data: list,
      //   colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      // )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }

// static List<charts.TickSpec<String>> _createTickSpec() {
//   DateTime now = DateTime.now();
//   int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
//   List<String> monthDays =
//       List.generate(daysInMonth, (index) => (index + 1).toString());
//
//   return monthDays.map((day) => charts.TickSpec(day)).toList();
// }
}

class Report {
  final String reportDate;
  final int productTotal;

  Report(this.reportDate, this.productTotal);
}

// class Product {
//   final int id;
//   final int machineId;
//   final String name;
//   final bool status;
//   final String update;
//
//   Product({required this.id, required this.machineId, required this.name, required this.status, required this.update});
//
//   factory Product.fromMap(Map<dynamic, dynamic> map) {
//     return Product(
//       id: map['id'],
//       machineId: map['machineId'],
//       name: map['name'],
//       status: map['status'],
//       update: map['update'],
//     );
//   }
// }
