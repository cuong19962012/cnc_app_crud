import 'package:cnc_crud/bar_chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

import 'firebase_options.dart';
import 'machine.dart';

class all_machine extends StatefulWidget {
  @override
  _all_machineState createState() => _all_machineState();
}

class _all_machineState extends State<all_machine> {
  final Future<FirebaseApp> _fApp =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  List<Machine> machines = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _fApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Conection error");
            } else if (snapshot.hasData) {
              return content();
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget content() {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref().child('machines');
    _testRef.onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      final machineList = dataSnapshot.value as Map<dynamic, dynamic>;
      setState(() {
        machines = machineList.entries
            .map((entry) => Machine.fromJson({
                  'id': entry.key,
                  ...entry.value,
                }))
            .toList();
      });
    });
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            constraints: BoxConstraints.expand(),
            color: Color(0xFFFFFFFF),
            child: ListView(
              children: [
                renderBack(context),
                renderSearch(context),
                renderMachine(context),
                // _buildMachine(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderBack(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.only(bottom: 19, left: 10, right: 10),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context); // Hàm này sẽ quay lại trang trước
              },
              child: Container(
                margin: EdgeInsets.only(top: 2, right: 21),
                width: 46,
                height: 34,
                child: Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderSearch(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFF2F3F2),
      ),
      padding: EdgeInsets.only(left: 12, right: 12),
      margin: EdgeInsets.all(16),
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 8),
            width: 20,
            height: 20,
            child: Image.network(
              'https://raw.githubusercontent.com/coredxor/images/main/v6.png',
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              width: double.infinity,
              height: double.infinity,
              child: TextField(
                style: TextStyle(
                  color: Color(0xFF7C7C7C),
                  fontSize: 14,
                ),
                controller: TextEditingController(
                  text: 'Search Everything...',
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleContainerTap(BuildContext context, int machineId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => barChart(machineId)),
    );
  }

  Widget renderMachine(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0), // Padding cho GridView
        child: GridView.count(
            crossAxisCount: 2, // Số lượng cột
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            // Sử dụng physics này để đảm bảo cuộn được
            children: machines
                .map((machine) => _buildMachine(
                    context, machine.name, machine.status, machine.id))
                .toList()));
  }

  Widget _buildMachine(
      BuildContext context, String machineName, bool status, int machineId) {
    double containerWidth = MediaQuery.of(context).size.width * 0.4;
    double containerHeight = 180.0; // Đã thay đổi chiều cao

    return GestureDetector(
      onTap: () {
        // Thực hiện hành động khi nhấn vào máy ở đây, ví dụ chuyển sang một trang khác
        return handleContainerTap(context, machineId);
      },
      child: Container(
        margin: EdgeInsets.all(40),
        // Đã giảm margin
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: status ? Color(0xFF00FF00) : Color(0xFF808080),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              machineName,
              style: TextStyle(
                color: Color(0xFF252624),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              status ? 'running' : 'stopped',
              style: TextStyle(
                color: Color(0xFF252624),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
