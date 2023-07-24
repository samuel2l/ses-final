import 'package:fin_fin_ses/project333/announcements.dart';
import 'package:fin_fin_ses/project333/courses.dart';
import 'package:fin_fin_ses/project333/fullNews.dart';
import 'package:fin_fin_ses/project333/gradess.dart';
import 'package:fin_fin_ses/project333/launch.dart';

import 'package:fin_fin_ses/project333/news.dart';
import 'package:fin_fin_ses/project333/routes.dart';
import 'package:fin_fin_ses/project333/ugLogin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      routes: {
        LoginPageRoute: (context) => const LoginPage(),
        FullNewsRoute: (context) =>  const FullNews() ,
        CoursesRoute:(context) =>  const Courses(),
       NewsPageRoute:(context)=> const News(),
       LaunchRoute:(context)=>const Launch(),
       AnnouncementsRoute: (context)=>const Announcements(),
       GradesRoute:(context)=> Gradess(),
      },
    );
  }
}

