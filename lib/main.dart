import 'package:flutter/material.dart';

import 'all_machine.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            constraints: BoxConstraints.expand(),
            color: Color(0xFFFFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                renderTitle(context),
                renderBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderTitle(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'CNC APP',
            style: TextStyle(
              color: Color(0xFF181725),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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

  final allMachineInstance = all_machine(); // hoặc AllMachine() tùy thuộc vào tên lớp bạn đã đặt

  void handleContainerTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => allMachineInstance),
    );
  }

  Widget renderRow1(BuildContext context) {
    return GestureDetector(
      onTap: () => handleContainerTap(context), // Gọi hàm xử lý sự kiện khi container 1 được nhấn
      child: Container(
        margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
        height: 200,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF53B175),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFF53B175),
                ),
                margin: EdgeInsets.only(right: 8),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      width: 110,
                      height: 75,
                      child: Image.network(
                        'https://cdn-icons-png.freepik.com/128/404/404485.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Factory 1',
                      style: TextStyle(
                        color: Color(0xFF181725),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => handleContainerTap(context), // Gọi hàm xử lý sự kiện khi container 2 được nhấn
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFF8A44C),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    color: Color(0xFFF8A44C),
                  ),
                  margin: EdgeInsets.only(left: 8),
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 25),
                        width: 110,
                        height: 75,
                        child: Image.network(
                          'https://cdn-icons-png.freepik.com/128/404/404485.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        'Factory 2',
                        style: TextStyle(
                          color: Color(0xFF181725),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget renderRow2(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      height: 200,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                handleContainerTap(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFF7A593),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFFF7A593),
                ),
                margin: EdgeInsets.only(right: 8),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      width: 110,
                      height: 75,
                      child: Image.network(
                        'https://cdn-icons-png.freepik.com/128/404/404485.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Factory 3',
                      style: TextStyle(
                        color: Color(0xFF181725),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                handleContainerTap(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFD3B0E0),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFFD3B0E0),
                ),
                margin: EdgeInsets.only(left: 8),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      width: 110,
                      height: 75,
                      child: Image.network(
                        'https://cdn-icons-png.freepik.com/128/404/404485.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Factory 4',
                      style: TextStyle(
                        color: Color(0xFF181725),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget renderRow3(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      height: 200,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                handleContainerTap(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFFDE598),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFFFDE598),
                ),
                margin: EdgeInsets.only(right: 8),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      width: 110,
                      height: 75,
                      child: Image.network(
                        'https://cdn-icons-png.freepik.com/128/404/404485.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Factory 5',
                      style: TextStyle(
                        color: Color(0xFF181725),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                handleContainerTap(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFB7DFF5),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFFB7DFF5),
                ),
                margin: EdgeInsets.only(left: 8),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      width: 110,
                      height: 75,
                      child: Image.network(
                        'https://cdn-icons-png.freepik.com/128/404/404485.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Factory 6',
                      style: TextStyle(
                        color: Color(0xFF181725),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget renderBody(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xFFffffff),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              renderSearch(context),
              renderRow1(context),
              renderRow2(context),
              renderRow3(context),
            ],
          ),
        ),
      ),
    );
  }
}