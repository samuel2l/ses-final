import 'package:fin_fin_ses/project333/constants.dart';
import 'package:fin_fin_ses/project333/routes.dart';
import 'package:fin_fin_ses/project333/ugLogin.dart';
import 'package:flutter/material.dart';

import 'news.dart';

class Launch extends StatefulWidget {
  const Launch({super.key});

  @override
  State<Launch> createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  @override
  void initState() {
    super.initState();
    AfterLaunch();
  }

  AfterLaunch() async {
    await Future.delayed(
      Duration(seconds: 5),
    );
    Navigator.of(context).pushNamedAndRemoveUntil(
      NewsPageRoute,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text('SES, making things work'),
                  Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/newses.jpg'))),
                      child: Image.asset('assets/images/newses.jpg')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
