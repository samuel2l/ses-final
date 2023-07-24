import 'package:flutter/material.dart';

import 'newsClass.dart';

class FullNews extends StatelessWidget {
  const FullNews({Key? key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final fullNews = arguments is NewsClass ? arguments : null;

    if (fullNews != null) {
      final title = fullNews.title;
      final body = fullNews.body;
      final author = fullNews.author;

      return SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                      image: AssetImage(fullNews.img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      body,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        wordSpacing: -3,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Text(
                  'By: $author',
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Handle the case when fullNews is null
      return Scaffold(
        body: Center(
          child: Text('No news available.'),
        ),
      );
    }
  }
}
