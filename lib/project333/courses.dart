import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fin_fin_ses/models/courseModel.dart';
import 'package:fin_fin_ses/project333/showErrorDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../baseUrl.dart';
import 'drawer.dart';
import 'secureStorageClass.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});
  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> with SingleTickerProviderStateMixin {
  late AnimationController _animationcontroller;
  late Animation<double> _animation;
  Color UgYellow = Color.fromARGB(255, 192, 160, 98);
  Color UgBlue = Color.fromARGB(255, 16, 3, 97);

  final _controller = ScrollController();
  final double itemSize = 100;
  List<Color> itemColors = [];
  final dio = Dio();
  Future<List<Course>> getHttp() async {
    final _storage = SecureStorage();
    dynamic token = await _storage.read('jwt');
    print(token);
    Response response = await dio.get(
      '$baseUrl/my_courses',
      options: Options(headers: {'auth': token}),
    );
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data is List) {
        final courses = response.data as List;
        return courses
            .map((e) => Course.fromJson(e as Map<String, dynamic>))
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

  // Future<void> _registerForCourse(String courseId, index) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(
  //           'https://geological-modules-eclipse-glasses.trycloudflare.com/register_course'),
  //       body: {'courseId': courseId},

  //     );

  Future<List<Course>> _registerForCourse(String courseId, index) async {
    final _storage = SecureStorage();
    dynamic token = await _storage.read('jwt');
    print(token);
    Response response = await dio.post(
      '$baseUrl/register_courses',
      data: {'course': courseId},
      options: Options(headers: {'auth': token}),
    );
    print(response.data);
    if (response.statusCode! >= 200) {
      //make this msg come like a notification
      // return showErrorDialog(context,
      //     'Successfully registered for the course. Status code: ${response.statusCode}');
      print(response.data);
      setState(() {
        itemColors[index] = Colors.blue;
      });
    } else {
      await showErrorDialog(context,
          'Failed to register for the course. Status code: ${response.statusCode}');
    }
    return [];
  }

  Future<List<Course>> _unregisterCourse(String courseId, index) async {
    final _storage = SecureStorage();
    dynamic token = await _storage.read('jwt');
    print(token);
    Response response = await dio.delete(
      '$baseUrl/course',
      data: {'course': courseId},
      options: Options(headers: {'auth': token}),
    );
    print(response.data);
    if (response.statusCode! >= 200) {
      //make this msg come like a notification
      // return showErrorDialog(context,
      //     'Successfully registered for the course. Status code: ${response.statusCode}');
      print(response.data);
      setState(() {
        itemColors[index] = UgBlue;
      });
    } else {
      await showErrorDialog(context,
          'Failed to unregister from the course. Status code: ${response.statusCode}');
    }
    return [];
  }

  // Future<void> _unregisterFromCourse(String courseId, index) async {
  //   try {
  //     final response = await http.delete(
  //       Uri.parse('$baseUrl/$courseId'),
  //     );
  //     if (response.statusCode >= 200 && response.statusCode <= 300) {
  //       setState(() {
  //         itemColors[index] = UgBlue;
  //       }); // Add your logic here to handle the successful unregistration
  //     } else {
  //       return showErrorDialog(context,
  //           'Failed to unregister from the course. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  @override
  void initState() {
    _animationcontroller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation =
        Tween<double>(begin: 0.0, end: 2 * pi).animate(_animationcontroller);
    _animationcontroller.repeat();

    _controller.addListener(() {
      setState(() {});
    });
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Your courses this sem',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  'Tap to register and press to unregister',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 35),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.4,
                  child: FutureBuilder<List<Course>>(
                    future: getHttp(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                                        borderRadius: BorderRadius.circular(10),
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
                          'No courses available.',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ));
                      } else {
                        return ListView.builder(
                          controller: _controller,
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            final itemOffset = index * itemSize;
                            final difference = _controller.offset - itemOffset;
                            final percent = 1 - (difference / (itemSize / 2));
                            double _opacity = percent;
                            double _scale = percent;

                            if (_opacity > 1.0) {
                              _opacity = 1.0;
                            }

                            if (_opacity < 1.0) {
                              _opacity = 0.0;
                            }
                            if (_scale > 1.0) {
                              _scale = 1.0;
                            }

                            return Opacity(
                              opacity: _opacity,
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..scale(_scale, 1.0),
                                child: GestureDetector(
                                  onDoubleTap: () async {
                                    await _registerForCourse(
                                        snapshot.data![index].code, index);

                                    //await _unregisterFromCourse(courseId);

                                    // Add other cases if needed for different states or actions.
                                  },
                                  onLongPress: () async {
                                    await _unregisterCourse(
                                        snapshot.data![index].code, index);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.only(right: 30, bottom: 2.5),
                                    height: itemSize,
                                    decoration: BoxDecoration(
                                      color: itemColors[index],
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    child: ListView(
                                      children: [
                                        Text(
                                          'Name: ${snapshot.data![index].name}',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w300,
                                              color: UgYellow),
                                        ),
                                        Text(
                                          'Course Code: ${snapshot.data![index].code}',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w300,
                                            color: UgYellow,
                                          ),
                                        ),
                                        Text(
                                          'Credits: ${snapshot.data![index].credit}',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w300,
                                            color: UgYellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      }
                    },
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
