import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fin_fin_ses/project333/secureStorageClass.dart';
import 'package:fin_fin_ses/project333/showErrorDialog.dart';
import 'package:flutter/material.dart';

import '../baseUrl.dart';
import '../models/announcementsModel.dart';
import 'drawer.dart';

// class Announcements extends StatefulWidget {
//   const Announcements({super.key});

//   @override
//   State<Announcements> createState() => _AnnouncementsState();
// }

// class _AnnouncementsState extends State<Announcements> {
//   Color UgYellow = Color.fromARGB(255, 192, 160, 98);
//   Color UgBlue = Color.fromARGB(255, 16, 3, 97);

//   final _controller = ScrollController();
//   final double itemSize = 100;
//   List<Color> itemColors = [];
//   final dio = Dio();

//   Future<List<Announcement>> getHttp() async {
//     final _storage = SecureStorage();
//     dynamic token = await _storage.read('jwt');
//     print(token);
//     Response response = await dio.get(
//       '$baseUrl/announcements',
//     );
//     print(response.data);
//     if (response.statusCode == 200) {
//       if (response.data is List) {
//         final Announcements = response.data as List;
//         return Announcements.map(
//           (e) => Announcement.fromJson(e as Map<String, dynamic>),
//         ).toList();
//       } else {
//         await showErrorDialog(
//           context,
//           'Unexpected data format: ${response.data.runtimeType}',
//         );
//         // print('Unexpected data format: ${response.data.runtimeType}');
//       }
//     } else {
//       await showErrorDialog(
//         context,
//         'Request failed with status: ${response.statusCode}',
//       );
//       // print();
//     }
//     return [];
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Call getHttp() here in the initState() method
//     getHttp();
//     _controller.addListener(() {
//       setState(() {});
//     });
//     itemColors = List.generate(15, (index) => UgBlue);
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
//     // Remove the call to getHttp() from here, as it's already called in initState()
//     // getHttp();

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
//                     color: UgBlue,
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(13),
//                       bottomRight: Radius.circular(13),
//                     ),
//                   ),
//                   // height: 100,
//                   child: Image.asset(
//                     'assets/images/newses-removebg-preview.png',
//                     height: 70,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   'Latest Announcements',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//                 SizedBox(height: 35),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height / 1.4,
//                   child: FutureBuilder<List<Announcement>>(
//                     future: getHttp(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: Image.asset('assets/images/newses.jpg'),
//                         );
//                       } else if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else if (snapshot.data == null ||
//                           snapshot.data!.isEmpty) {
//                         return Center(
//                           child: Text(
//                             'No announcements',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
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
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   margin:
//                                       EdgeInsets.only(right: 30, bottom: 2.5),
//                                   height: itemSize,
//                                   decoration: BoxDecoration(
//                                     color: itemColors[index],
//                                     borderRadius: BorderRadius.circular(13),
//                                   ),
//                                   child: ListView(
//                                     children: [
//                                       Text(
//                                         'Name: ${snapshot.data![index].title}',
//                                         style: TextStyle(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.w300,
//                                           color: UgYellow,
//                                         ),
//                                       ),
//                                       Text(
//                                         'Course Code: ${snapshot.data![index].content}',
//                                         style: TextStyle(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w300,
//                                           color: UgYellow,
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Credits: ${snapshot.data![index].by}',
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: UgYellow,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Credits: ${snapshot.data![index].DateCreated}',
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: UgYellow,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
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

class Announcements extends StatefulWidget {
  const Announcements({super.key});
  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationcontroller;
  late Animation<double> _animation;

  Color UgYellow = Color.fromARGB(255, 192, 160, 98);
  Color UgBlue = Color.fromARGB(255, 16, 3, 97);

  final _controller = ScrollController();
  final double itemSize = 100;
  List<Color> itemColors = [];
  final dio = Dio();
  Future<List<Announcement>> getHttp() async {
    final _storage = SecureStorage();
    dynamic token = await _storage.read('jwt');
    print(token);
    Response response = await dio.get(
      '$baseUrl/announcements',
      options: Options(headers: {'auth': token}),
    );
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data is List) {
        final Announcements = response.data as List;
        return Announcements.map(
            (e) => Announcement.fromJson(e as Map<String, dynamic>)).toList();
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
                    'Latest Announcements',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.4,
                  child: FutureBuilder<List<Announcement>>(
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
                          'No announcements available',
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
                                        ' ${snapshot.data![index].title}',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w300,
                                            color: UgYellow),
                                      ),
                                      Text(
                                        'Content: ${snapshot.data![index].content}',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w300,
                                          color: UgYellow,
                                        ),
                                      ),
                                      Text(
                                        'By: ${snapshot.data![index].by}',
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
