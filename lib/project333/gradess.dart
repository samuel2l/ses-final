import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fin_fin_ses/models/courseModel.dart';
import 'package:fin_fin_ses/project333/showErrorDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../baseUrl.dart';
import '../models/gradesModel.dart';
import 'drawer.dart';
import 'secureStorageClass.dart';

class Gradess extends StatefulWidget {
  const Gradess({super.key});
  @override
  State<Gradess> createState() => _GradessState();
}

class _GradessState extends State<Gradess> with SingleTickerProviderStateMixin {
  late AnimationController _animationcontroller;
  late Animation<double> _animation;
  Color UgYellow = Color.fromARGB(255, 192, 160, 98);
  Color UgBlue = Color.fromARGB(255, 16, 3, 97);

  final _controller = ScrollController();
  final double itemSize = 100;
  List<Color> itemColors = [];
  final dio = Dio();
  Future<List<Grades>> getHttp() async {
    final _storage = SecureStorage();
    dynamic token = await _storage.read('jwt');
    print(token);
    Response response = await dio.get(
      '$baseUrl/grades',
      options: Options(headers: {'auth': token}),
    );
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data is List) {
        final Gradess = response.data as List;
        return Gradess.map((e) => Grades.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        await showErrorDialog(
            context, 'Unexpected data format: ${response.data.runtimeType}');

        // print('Unexpected data format: ${response.data.runtimeType}');
      }
    } else {
      await showErrorDialog(
          context, 'Request failed with status: ${response.statusCode}');
      // print();
    }
    return [];
  }

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {});
    });
    _animationcontroller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation =
        Tween<double>(begin: 0.0, end: 2 * pi).animate(_animationcontroller);
    _animationcontroller.repeat();

    itemColors = List.generate(15, (index) => UgBlue);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    getHttp();
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        drawer: Drawerr(),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: UgBlue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(13),
                      bottomRight: Radius.circular(13))),
              // height: 100,
              child: Image.asset(
                'assets/images/newses-removebg-preview.png',
                height: 70,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ... existing code ...

                // Use a Container to limit the table height and make it scrollable
                Padding(
                  padding: const EdgeInsets.only(top: 80, right: 3, left: 3),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: FutureBuilder<List<Grades>>(
                      future: getHttp(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Column(
                              children: [
                                Text(
                                  'Loading...',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: UgBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                                AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return Transform(
                                      alignment: Alignment
                                          .center, // this is you setting the point of transformation basically ie. your pivot point
                                      transform: Matrix4.identity()
                                        ..rotateY(_animation.value),
                                      child: Container(
                                        width: 200,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                            'assets/images/newses-removebg-preview.png'),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return Center(
                              child: Text(
                            'No Grades available.',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ));
                        } else {
                          // Build the Table using Table constructor
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Table(
                              border: TableBorder.all(color: Colors.green),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: const {
                                0: FlexColumnWidth(1.5),
                                1: FlexColumnWidth(2.0),
                                2: FlexColumnWidth(1.0),
                                3: FlexColumnWidth(1.0),
                              },
                              children: [
                                // Table headers
                                TableRow(
                                  children: [
                                    TableCell(child: Text('Course Code')),
                                    TableCell(child: Text('Title')),
                                    TableCell(child: Text('Credits')),
                                    TableCell(child: Text('Grade Point')),
                                  ],
                                ),
                                // Table rows
                                ...snapshot.data!.map((grade) {
                                  return TableRow(
                                    children: [
                                      TableCell(child: Text(grade.courseId)),
                                      TableCell(child: Text(grade.name)),
                                      TableCell(
                                          child: Text(grade.credit.toString())),
                                      TableCell(child: Text(grade.grade)),
                                    ],
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                _globalKey.currentState?.openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
          ],
        ),
      ),
    );
  }
}
