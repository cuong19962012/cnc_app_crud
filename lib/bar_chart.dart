import 'package:cnc_crud/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'firebase_options.dart';

class barChart extends StatefulWidget {
  int machineId;

  barChart(this.machineId);

  @override
  _barChartState createState() => _barChartState();
}

class _barChartState extends State<barChart> {
  final Future<FirebaseApp> _fApp =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _fApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.data);
              return Text("Conection error");
            } else if (snapshot.hasData) {
              return content(widget.machineId);
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget content(int machineId) {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref().child('products');
    _testRef.onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      final productList = dataSnapshot.value as Map<dynamic, dynamic>;
      final filteredProducts = productList.entries
          .map((entry) => Product.fromJson({
                'id': entry.key,
                ...entry.value,
              }))
          .where((product) => product.machineId == machineId)
          .toList();
      setState(() {
        products = filteredProducts;
      });
    });
    return MaterialApp(
      title: 'Bar Chart with Secondary Axis Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bar Chart '),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            child: BarChartWithSecondaryAxis.withSampleData(products),
          ),
        ),
      ),
    );
  }
}

class BarChartWithSecondaryAxis extends StatelessWidget {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  final List<charts.Series<Report, String>> seriesList;
  final bool animate;

  BarChartWithSecondaryAxis(this.seriesList, {this.animate = true});

  factory BarChartWithSecondaryAxis.withSampleData(List<Product> products) {
    return BarChartWithSecondaryAxis(
      _createSampleData(products),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec:
            charts.BasicNumericTickProviderSpec(desiredTickCount: 3),
        viewport: charts.NumericExtents(0, 2),
      ),
      secondaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec:
            charts.BasicNumericTickProviderSpec(desiredTickCount: 3),
      ),
      defaultInteractions: false,
      // Thêm renderer để thiết lập màu sắc cho từng cột
      customSeriesRenderers: [
        charts.BarTargetLineRendererConfig<String>(
          // ID của cột phụ
          customRendererId: secondaryMeasureAxisId,
          groupingType: charts.BarGroupingType.grouped,
        ),
      ],
      // Thêm legend để hiển thị chú thích
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
          horizontalFirst: false,
          desiredMaxRows: 2,
          cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
        ),
      ],
    );
  }

  static List<charts.Series<Report, String>> _createSampleData(
      List<Product> list) {
    final dateDelivery = ["01-01-2024", "02-01-2024"];
    List<Report> reportList = [];

    for (String date in dateDelivery) {
      int productCount = 0;
      for (Product product in list) {
        if (product.updateTime==date) {
          productCount++;
        }
      }
      Report report = Report(date, productCount);
      reportList.add(report);
    }
    
    return [
      charts.Series<Report, String>(
        id: 'products',
        domainFn: (sales, _) => sales.reportDate,
        measureFn: (sales, _) => sales.productTotal,
        data: reportList,
        // Thiết lập màu cho cột chính
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
    ];
  }
}

class Report {
  final String reportDate;
  final int productTotal;

  Report(this.reportDate, this.productTotal);
}
