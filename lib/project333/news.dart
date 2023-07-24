import 'package:fin_fin_ses/project333/header_widget.dart';
import 'package:fin_fin_ses/project333/routes.dart';
import 'package:fin_fin_ses/project333/slider.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'drawer.dart';
import 'newsClass.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final List<NewsClass> _newsList = [
    NewsClass(
      author: 'Lionel Messi',
      body:
          'Nullam sed augue a turpis bibendum cursus. Suspendisse potenti. Praesent mi ligula, mollis quis elit ac, eleifend vestibulum ex. Nullam quis sodales tellus. Integer feugiat dolor et nisi semper luctus. Nulla egestas nec augue facilisis pharetra. Sed ultricies nibh a odio aliquam, eu imperdiet purus aliquam. Donec id ante ne Nullam sed augue a turpis bibendum cursus. Suspendisse potenti. Praesent mi ligula, mollis quis elit ac, eleifend vestibulum ex. Nullam quis sodales tellus. Integer feugiat dolor et nisi semper luctus. Nulla egestas nec augue facilisis pharetra. Sed ultricies nibh a odio aliquam, eu imperdiet purus aliquam. Donec id ante necNullam sed augue a turpis bibendum cursus. Suspendisse potenti. Praesent mi ligula, mollis quis elit ac, eleifend vestibulum ex. Nullam quis sodales tellus. Integer feugiat dolor et nisi semper luctus. Nulla egestas nec augue facilisis pharetra. Sed ultricies nibh a odio aliquam, eu imperdiet purus aliquam. Donec id ante necNullam sed augue a turpis bibendum cursus. Suspendisse potenti. Praesent mi ligula, mollis quis elit ac, eleifend vestibulum ex. Nullam quis sodales tellus. Integer feugiat dolor et nisi semper luctus. Nulla egestas nec augue facilisis pharetra. Sed ultricies nibh a odio aliquam, eu imperdiet purus aliquam. Donec id ante necNullam sed augue a turpis bibendum cursus. Suspendisse potenti. Praesent mi ligula, mollis quis elit ac, eleifend vestibulum ex. Nullam quis sodales tellus. Integer feugiat dolor et nisi semper luctus. Nulla egestas nec augue facilisis pharetra. Sed ultricies nibh a odio aliquam, eu imperdiet purus aliquam. Donec id ante necNullam sed augue a turpis bibendum cursus. Suspendisse potenti. Praesent mi ligula, mollis quis elit ac, eleifend vestibulum ex. Nullam quis sodales tellus. Integer feugiat dolor et nisi semper luctus. Nulla egestas nec augue facilisis pharetra. Sed ultricies nibh a odio aliquam, eu imperdiet purus aliquam. Donec id ante nec',
      title: 'Excited for the tech seminar!',
      img: 'assets/images/tech_talk.jpg',
    ),
    NewsClass(
      author: 'Lionel Messi',
      body:
          'Nullam sed augue a turpis bibendum cursus. Suspendisse potenti. Praesent mi ligula, mollis quis elit ac, eleifend vestibulum ex. Nullam quis sodales tellus. Integer feugiat dolor et nisi semper luctus. Nulla egestas nec augue facilisis pharetra. Sed ultricies nibh a odio aliquam, eu imperdiet purus aliquam. Donec id ante nec',
      title: 'The new UG app is here',
      img: 'assets/images/bkg2.jpg',
    ),
    NewsClass(
      author: 'Lionel Messi',
      body:
          'Nullam sed augue a turpis bibendum cursus. Suspendisse potenti. Praesent mi ligula, mollis quis elit ac, eleifend vestibulum ex. Nullam quis sodales tellus. Integer feugiat dolor et nisi semper luctus. Nulla egestas nec augue facilisis pharetra. Sed ultricies nibh a odio aliquam, eu imperdiet purus aliquam. Donec id ante nec',
      title: 'Vetting results are out!',
      img: 'assets/images/vetting_resulta.jpg',
    ),
    NewsClass(
      author: 'Lionel Messi',
      body:
          'Nullam sed augue a turpis bibendum cursus. Suspendisse potenti. Praesent mi ligula, mollis quis elit ac, eleifend vestibulum ex. Nullam quis sodales tellus. Integer feugiat dolor et nisi semper luctus. Nulla egestas nec augue facilisis pharetra. Sed ultricies nibh a odio aliquam, eu imperdiet purus aliquam. Donec id ante nec',
      title: 'The neis here',
      img: 'assets/images/photography.jpeg',
    ),
  ];
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        drawer: Drawerr(),
        // drawer: Drawerr(student_mail: decodedData['first name'], text: decodedData['email'],),
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
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
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    '20 years of elegance and excellence!!!',
                    style: TextStyle(
                        color: UgBlue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 300,
                  child: MySlider(),
                ),
                SizedBox(height: 5),
                Text(
                  'What\'s new in  SES?',
                  style: TextStyle(color: UgBlue, fontSize: 20),
                ),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _newsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          margin: EdgeInsets.only(right: 10, top: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                FullNewsRoute,
                                arguments: _newsList[index],
                              );
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                _newsList[index].img),
                                            fit: BoxFit.cover),
                                      )),
                                  Text(
                                    _newsList[index].title,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  Text(
                                    _newsList[index].body,
                                    style: TextStyle(color: Colors.black),
                                    maxLines: 2,
                                  ),
                                  Text(
                                    'By ${_newsList[index].author}',
                                  ),
                                ]),
                          ),
                        );
                      }),
                )
              ],
            ),
            IconButton(
                onPressed: () {
                  _globalKey.currentState?.openDrawer();
                },
                icon: Icon(Icons.menu)),
          ],
        ),
      ),
    );
  }
}
