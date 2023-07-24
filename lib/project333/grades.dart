// import 'package:dio/dio.dart';
// import 'package:fin_fin_ses/models/courseModel.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../models/gradesModel.dart';
// import 'constants.dart';
// import 'drawer.dart';
// import 'secureStorageClass.dart';

// class MyGrades extends StatefulWidget {
//   const MyGrades({super.key});

//   @override
//   State<MyGrades> createState() => _MyGradesState();
// }

// class _MyGradesState extends State<MyGrades> {
//   final _controller = ScrollController();
//   final double itemSize = 100;
//   List<Color> itemColors = List.generate(15, (index) => UgBlue);
//   final dio = Dio();

//   // Future<User>
//   Future<List<Grades>> getHttp() async {
//     final _storage = SecureStorage();
//     dynamic token = await _storage.read('jwt');
//     print(token);
//     Response response = await dio.get(
//       'https://merchandise-quebec-develop-instrumentation.trycloudflare.com/my_MyGrades',
//       options: Options(headers: {'auth': token}),
//     );
//     print(response.data);
//     if (response.statusCode == 200) {
//       if (response.data is List) {
//         final MyGrades = response.data as List;
//         return MyGrades
//             .map((e) => Grades.fromJson(e as Map<String, dynamic>))
//             .toList();
//       } else {
//         print('Unexpected data format: ${response.data.runtimeType}');
//       }
//     } else {
//       print('Request failed with status: ${response.statusCode}');
//     }
//     return [];
//   }

//   // Future<void> _registerForCourse(String courseId) async {
//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse(
//   //           'https://merchandise-quebec-develop-instrumentation.trycloudflare.com/register_course'),
//   //       body: [courseId],
//   //     );
//   //     if (response.statusCode == 200) {
//   //       print('Successfully registered for the course with id: $courseId');
//   //       // Add your logic here to handle the successful registration
//   //     } else {
//   //       print(
//   //           'Failed to register for the course. Status code: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     print('Error: $e');
//   //   }
//   // }

//   // Future<void> _unregisterFromCourse(String courseId) async {
//   //   try {
//   //     final response = await http.delete(
//   //       Uri.parse(
//   //           'https://closest-shadow-germany-completion.trycloudflare.com/course/$courseId'),
//   //     );
//   //     if (response.statusCode == 200) {
//   //       print('Successfully unregistered from the course with id: $courseId');
//   //       // Add your logic here to handle the successful unregistration
//   //     } else {
//   //       print(
//   //           'Failed to unregister from the course. Status code: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     print('Error: $e');
//   //   }
//   // }

//   @override
//   void initState() {
//     _controller.addListener(() {
//       setState(() {});
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(() {
//       setState(() {});
//     });
//     super.dispose();
//   }

//   GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     getHttp();
//     return SafeArea(
//       child: Scaffold(
//         key: _globalKey,
//         drawer: Drawerr(),
//         body: Stack(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       color: UgBlue,
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(13),
//                           bottomRight: Radius.circular(13))),
//                   // height: 100,
//                   child: Image.asset(
//                     'assets/images/newses-removebg-preview.png',
//                     height: 70,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Text(
//                     'Your Grades',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 35),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height / 1.4,
//                   child: FutureBuilder<List<Grades>>(
//                     future: getHttp(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                             child: Image.asset(
//                                 'assets/images/newses-removebg-preview .png'));
//                       } else if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else if (snapshot.data == null ||
//                           snapshot.data!.isEmpty) {
//                         return Center(
//                           child: Text('No grades available'),
//                         );
//                       } else {
//                         return ListView.builder(
//                           controller: _controller,
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: ((context, index) {
//                             final itemOffset = index * itemSize;
//                             final difference = _controller.offset - itemOffset;
//                             final percent = 1 - (difference / (itemSize / 2));
//                             double _opacity = percent;
//                             double _scale = percent;

//                             if (_opacity > 1.0) {
//                               _opacity = 1.0;
//                             }

//                             if (_opacity < 1.0) {
//                               _opacity = 0.0;
//                             }
//                             if (_scale > 1.0) {
//                               _scale = 1.0;
//                             }

//                             return Opacity(
//                               opacity: _opacity,
//                               child: Transform(
//                                 alignment: Alignment.center,
//                                 transform: Matrix4.identity()
//                                   ..scale(_scale, 1.0),
//                                 child: GestureDetector(
//                                   child: Container(
//                                     width: MediaQuery.of(context).size.width,
//                                     margin:
//                                         EdgeInsets.only(right: 30, bottom: 2.5),
//                                     height: itemSize,
//                                     decoration: BoxDecoration(
//                                       color: itemColors[index],
//                                       borderRadius: BorderRadius.circular(13),
//                                     ),
//                                     child: ListView(
//                                       children: [
//                                         Text(
//                                           'Name: ${snapshot.data![index].name}',
//                                           style: TextStyle(
//                                               fontSize: 24,
//                                               fontWeight: FontWeight.w300,
//                                               color: UgYellow),
//                                         ),
//                                         Text(
//                                           'Course Code: ${snapshot.data![index].code}',
//                                           style: TextStyle(
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.w300,
//                                             color: UgYellow,
//                                           ),
//                                         ),
//                                         Text(
//                                           'Credits: ${snapshot.data![index].credit}',
//                                           style: TextStyle(
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.w300,
//                                             color: UgYellow,
//                                           ),
//                                         ),
//                                         Text(
//                                           'Credits: ${snapshot.data![index].credit}',
//                                           style: TextStyle(
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.w300,
//                                             color: UgYellow,
//                                           ),
//                                         ),
                                        
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             IconButton(
//               onPressed: () {
//                 _globalKey.currentState?.openDrawer();
//               },
//               icon: Icon(Icons.menu),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
